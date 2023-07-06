//
//  FeedViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/07/23.
//

import UIKit
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol RequesterInfo {
    var name: String { get }
    var bloodtype: String { get }
    var description: String { get }
}

struct Individual: Identifiable, Hashable, Codable, RequesterInfo {
    let id: String
    let name: String
    let bloodtype: String
    let age: Int
    let description: String
}

struct Hospital: Identifiable, Hashable, Codable, RequesterInfo {
    let id: String
    let name: String
    let bloodtype: String
    let description: String
}

class FeedViewModel: ObservableObject {
    @Published var individuals: [Individual] = []
    
    @Published var hospitals: [Hospital] = []
    
    private var db = Firestore.firestore()
    
    @Published var individualsLoading = true
    @Published var hospitalsLoading = true
    
    init() {
        fetchIndividualData()
        fetchHospitalData()
    }
    
    func fetchIndividualData() {
        individualsLoading = true
        
        db.collection("requests").whereField("madeByHospital", isEqualTo: false).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.handleDocumentSnapshot(querySnapshot: querySnapshot, forHospitals: false)
            }
        }
    }
    
    func fetchHospitalData() {
        hospitalsLoading = true
        
        db.collection("requests").whereField("madeByHospital", isEqualTo: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.handleDocumentSnapshot(querySnapshot: querySnapshot, forHospitals: true)
            }
        }
    }
    
    private func handleDocumentSnapshot(querySnapshot: QuerySnapshot?, forHospitals: Bool) {
        let totalDocuments = querySnapshot?.documents.count ?? 0
        var processedDocuments = 0
        
        querySnapshot?.documents.forEach { document in
            if let authorUID = document.data()["authorUID"] as? String,
               let additionalInfo = document.data()["additionalInfo"] as? String {
                
                self.db.collection("users").document(authorUID).getDocument { (document, error) in
                    if let document = document, document.exists {
                        guard let bloodtype = document.data()?["bloodtype"] as? String else { return }
                        guard let fakename = document.data()?["fakename"] as? String else { return }
                        
                        if forHospitals {
                            let newHospital = Hospital(id: authorUID, name: fakename, bloodtype: bloodtype, description: additionalInfo)
                            self.hospitals.append(newHospital)
                        } else {
                            guard let dateOfBirthTimestamp = document.data()?["dateOfBirth"] as? Timestamp else { return }
                            let dateOfBirth = dateOfBirthTimestamp.dateValue()
                            let calendar = Calendar.current

                            let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
                            guard let age = ageComponents.year else { return }
                            
                            let newIndividual = Individual(id: authorUID, name: fakename, bloodtype: bloodtype, age: age, description: additionalInfo)
                            self.individuals.append(newIndividual)
                        }
                    }
                    
                    processedDocuments += 1
                    
                    if processedDocuments == totalDocuments {
                        withAnimation {
                            if forHospitals {
                                self.hospitalsLoading = false
                            } else {
                                self.individualsLoading = false
                            }
                        }
                    }
                }
            }
        }
    }
}