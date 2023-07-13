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
import FirebaseStorage

protocol RequesterInfo {
    var name: String { get }
    var bloodtype: String { get }
    var description: String { get }
    var coordinateX: Double { get }
    var coordinateY: Double { get }
    var acidente: Bool { get }
    var cirurgia: Bool { get }
    var doenca: Bool { get }
    var outro: Bool { get }
    var tratamento: Bool { get }
    func countTrueBooleans() -> Int
}

extension RequesterInfo {
    func countTrueBooleans() -> Int {
        return [acidente, cirurgia, doenca, outro, tratamento].filter { $0 }.count
    }
}

struct Individual: Identifiable, Hashable, RequesterInfo {
    let authorId: String
    let id: String
    let name: String
    let bloodtype: String
    let age: Int
    let description: String
    let coordinateX: Double
    let coordinateY: Double
    let acidente: Bool
    let cirurgia: Bool
    let doenca: Bool
    let outro: Bool
    let tratamento: Bool
    var image: UIImage
}

struct Hospital: Identifiable, Hashable, RequesterInfo {
    let authorId: String
    let id: String
    let name: String
    let bloodtype: String
    let description: String
    let coordinateX: Double
    let coordinateY: Double
    let acidente: Bool
    let cirurgia: Bool
    let doenca: Bool
    let outro: Bool
    let tratamento: Bool
    var image: UIImage
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
    
    func fetchDataAndDo(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        fetchIndividualDataAndDo() {
            group.leave()
        }
        
        group.enter()
        fetchHospitalDataAndDo() {
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func fetchIndividualDataAndDo(completion: @escaping () -> Void = {}) {
        individualsLoading = true
        
        individuals = [Individual]()
        db.collection("requests").whereField("madeByHospital", isEqualTo: false).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion()
            } else {
                self.handleDocumentSnapshot(querySnapshot: querySnapshot, forHospitals: false)
                self.individualsLoading = false
                completion()
            }
        }
    }

    func fetchHospitalDataAndDo(completion: @escaping () -> Void = {}) {
        hospitalsLoading = true
        
        hospitals = [Hospital]()
        db.collection("requests").whereField("madeByHospital", isEqualTo: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion()
            } else {
                self.handleDocumentSnapshot(querySnapshot: querySnapshot, forHospitals: true)
                self.hospitalsLoading = false
                completion()
            }
        }
    }
    
    func fetchIndividualData() {
        individualsLoading = true
        
        individuals = [Individual]()
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
        
        hospitals = [Hospital]()
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
            let documentName = document.documentID
            guard let coordinateX = document.data()["coordinateX"] as? Double else { return }
            guard let coordinateY = document.data()["coordinateY"] as? Double else { return }
            guard let acidente = document.data()["acidente"] as? Bool else { return }
            guard let cirurgia = document.data()["cirurgia"] as? Bool else { return }
            guard let doenca = document.data()["doenca"] as? Bool else { return }
            guard let outro = document.data()["outro"] as? Bool else { return }
            guard let tratamento = document.data()["tratamento"] as? Bool else { return }
            
            if let authorUID = document.data()["authorUID"] as? String,
               let additionalInfo = document.data()["additionalInfo"] as? String {
                self.db.collection("users").document(authorUID).getDocument { (document, error) in
                    if let document = document, document.exists {
                        guard let bloodtype = document.data()?["bloodtype"] as? String else { return }
                        guard let fakename = document.data()?["fakename"] as? String else { return }

                        self.downloadProfileImage(for: authorUID) { image in
                            if forHospitals {
                                let newHospital = Hospital(authorId: authorUID, id: documentName, name: fakename, bloodtype: bloodtype, description: additionalInfo, coordinateX: coordinateX, coordinateY: coordinateY, acidente: acidente, cirurgia: cirurgia, doenca: doenca, outro: outro, tratamento: tratamento, image: image)
                                self.hospitals.append(newHospital)
                            } else {
                                guard let dateOfBirthTimestamp = document.data()?["dateOfBirth"] as? Timestamp else { return }
                                let dateOfBirth = dateOfBirthTimestamp.dateValue()
                                let calendar = Calendar.current
                                
                                let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
                                guard let age = ageComponents.year else { return }
                                
                                let newIndividual = Individual(authorId: authorUID, id: documentName, name: fakename, bloodtype: bloodtype, age: age, description: additionalInfo, coordinateX: coordinateX, coordinateY: coordinateY, acidente: acidente, cirurgia: cirurgia, doenca: doenca, outro: outro, tratamento: tratamento, image: image)
                                self.individuals.append(newIndividual)
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
    }

    func downloadProfileImage(for userUID: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let profileImageRef = storage.reference().child("profileImages/\(userUID).jpg")

        profileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                completion(UIImage(named: "3d_avatar_28")!)
            } else if let data = data {
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(UIImage(named: "3d_avatar_28")!)
                }
            }
        }
    }

    
    func orderByProximity(coordinateX: Double, coordinateY: Double) {
        withAnimation {
            self.individuals.sort {
                let distance1 = pow($0.coordinateX - coordinateX, 2) + pow($0.coordinateY - coordinateY, 2)
                let distance2 = pow($1.coordinateX - coordinateX, 2) + pow($1.coordinateY - coordinateY, 2)
                return distance1 < distance2
            }
            self.hospitals.sort {
                let distance1 = pow($0.coordinateX - coordinateX, 2) + pow($0.coordinateY - coordinateY, 2)
                let distance2 = pow($1.coordinateX - coordinateX, 2) + pow($1.coordinateY - coordinateY, 2)
                return distance1 < distance2
            }
        }
    }
    
    func orderByTrueBooleans() {
        withAnimation {
            self.individuals.sort {
                $0.countTrueBooleans() > $1.countTrueBooleans()
            }
            self.hospitals.sort {
                $0.countTrueBooleans() > $1.countTrueBooleans()
            }
        }
    }
    
    func restoreOriginalOrder() {
        fetchIndividualData()
        fetchHospitalData()
    }
}
