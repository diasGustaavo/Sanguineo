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

struct Hospital: Identifiable, Hashable, RequesterInfo {
    let id = UUID()
    let image: UIImage
    let name: String
    let bloodtype: String
    let description: String
}

class FeedViewModel: ObservableObject {
    @Published var individuals: [Individual] = []
    
    @Published var hospitals: [Hospital] = (0..<5).map { _ in
        Hospital(image: UIImage(named: "3d_avatar_28_hospital")!,
                 name: "Hemocentro",
                 bloodtype: "O-",
                 description: "Precisamos urgente de sangue O+ para inúmeros pacientes")
    }
    
    private var db = Firestore.firestore()
    
    @Published var individualsLoading = true
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        individualsLoading = true
        
        db.collection("requests").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let totalDocuments = querySnapshot?.documents.count ?? 0
                var processedDocuments = 0
                
                querySnapshot?.documents.forEach { document in
                    if let authorUID = document.data()["authorUID"] as? String,
                       let additionalInfo = document.data()["additionalInfo"] as? String {
                        
                        self.db.collection("users").document(authorUID).getDocument { (document, error) in
                            if let document = document, document.exists {
                                guard let bloodtype = document.data()?["bloodtype"] as? String else { return }
                                guard let fakename = document.data()?["fakename"] as? String else { return }
                                guard let dateOfBirthTimestamp = document.data()?["dateOfBirth"] as? Timestamp else { return }

                                let dateOfBirth = dateOfBirthTimestamp.dateValue()
                                let calendar = Calendar.current

                                let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
                                guard let age = ageComponents.year else { return }
                                
                                let newIndividual = Individual(id: authorUID, name: fakename, bloodtype: bloodtype, age: age, description: additionalInfo)
                                self.individuals.append(newIndividual)
                            }
                            
                            processedDocuments += 1
                            
                            if processedDocuments == totalDocuments {
                                withAnimation {
                                    self.individualsLoading = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
