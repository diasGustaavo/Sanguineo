//
//  FeedViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/07/23.
//

import UIKit
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
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        db.collection("requests").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                querySnapshot?.documents.forEach { document in
                    if let authorUID = document.data()["authorUID"] as? String {
                        if let additionalInfo = document.data()["additionalInfo"] as? String {
                            print(authorUID)
                            print(additionalInfo)
                            
                            // Fetch bloodtype from users collection
                            self.db.collection("users").document(authorUID).getDocument { (document, error) in
                                if let document = document, document.exists {
                                    guard let bloodtype = document.data()?["bloodtype"] as? String else { return }
                                    guard let fakename = document.data()?["fakename"] as? String else { return }
                                    guard let age = document.data()?["age"] as? String else { return }
                                    
                                    let newIndividual = Individual(id: authorUID, name: fakename, bloodtype: bloodtype, age: Int(age)!, description: additionalInfo)
                                    self.individuals.append(newIndividual)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
