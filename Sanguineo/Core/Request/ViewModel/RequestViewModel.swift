//
//  RequestViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 26/06/23.
//

import FirebaseFirestore
import UIKit
import FirebaseStorage


class RequestViewModel: ObservableObject {
    @Published var cirurgia: Bool = false
    @Published var acidente: Bool = false
    @Published var doenca: Bool = false
    @Published var tratamento: Bool = false
    @Published var outro: Bool = false
    @Published var additionalInfo: String = ""
    @Published var hemocentro: String = ""
    @Published var requests = [Request]()
    @Published var profileImagesData: [String: Data] = [:]
    @Published var profileImage: UIImage = UIImage(named: "3davatar2")!
    
    @Published var isLoading = true
    @Published var isPublicationLoading = false
    
    func saveRequest(authorUID: String, reqUID: String = "", xCoordinate: Double, yCoordinate: Double) {
        let request = Request(id: nil, cirurgia: cirurgia, acidente: acidente, doenca: doenca, tratamento: tratamento, outro: outro, additionalInfo: additionalInfo, hemocentro: hemocentro, authorUID: authorUID, madeByHospital: false, date: Date(), coordinateX: xCoordinate, coordinateY: yCoordinate)
        
        do {
            var requestDocument = try Firestore.Encoder().encode(request)
            // Remove the ID field from the document, because Firestore will automatically assign it an ID
            requestDocument["id"] = nil
            
            let db = Firestore.firestore()
            
            if reqUID.isEmpty {
                // If reqUID is empty, add a new document
                db.collection("requests").addDocument(data: requestDocument) { error in
                    if let error = error {
                        print("DEBUG: Error adding request: \(error)")
                    } else {
                        self.resetFields()
                    }
                }
            } else {
                // If reqUID is not empty, update the existing document with the reqUID
                db.collection("requests").document(reqUID).setData(requestDocument) { error in
                    if let error = error {
                        print("DEBUG: Error updating request: \(error)")
                    } else {
                        self.resetFields()
                    }
                }
            }
        } catch {
            print("DEBUG: Error encoding request: \(error)")
        }
    }
    
    func resetFields() {
        cirurgia = false
        acidente = false
        doenca = false
        tratamento = false
        outro = false
        additionalInfo = ""
        hemocentro = ""
    }
    
    func fetchRequestsAndDo(for authorUID: String, completion: @escaping () -> Void) {
        isLoading = true
        let db = Firestore.firestore()
        db.collection("requests").whereField("authorUID", isEqualTo: authorUID).getDocuments { querySnapshot, error in
            if let error = error {
                print("DEBUG: Error getting requests: \(error)")
                self.isLoading = false
                completion()
            } else if let querySnapshot = querySnapshot {
                self.requests = querySnapshot.documents.compactMap { document -> Request? in
                    var request = try? document.data(as: Request.self)
                    request?.id = document.documentID
                    return request
                }
                self.isLoading = false
                completion()
            }
        }
    }
    
    func fetchSingleProfileImage(for authorUID: String) {
        let imageName = authorUID + ".jpg"
        let imagePath = "profileImages/\(imageName)"
        let storage = Storage.storage().reference()
        storage.child(imagePath).getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching profile image: \(error)")
            } else if let data = data {
                DispatchQueue.main.async {
                    self.profileImage = UIImage(data: data) ?? UIImage(named: "3davatar2")!
                }
            }
        }
    }
    
    func fetchProfileImage(for authorUID: String, completion: @escaping () -> Void) {
        let imageName = authorUID + ".jpg"
        let imagePath = "profileImages/\(imageName)"
        let storage = Storage.storage().reference()
        storage.child(imagePath).getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching profile image: \(error)")
            } else if let data = data {
                DispatchQueue.main.async {
                    self.profileImagesData[authorUID] = data
                }
            }
            completion()
        }
    }
    
    func fetchRequests(for authorUID: String) {
        isLoading = true
        self.fetchSingleProfileImage(for: authorUID)
        let db = Firestore.firestore()
        db.collection("requests").whereField("authorUID", isEqualTo: authorUID).getDocuments { querySnapshot, error in
            if error != nil {
                self.isLoading = false
            } else if let querySnapshot = querySnapshot {
                let group = DispatchGroup()
                self.requests = querySnapshot.documents.compactMap { document -> Request? in
                    var request = try? document.data(as: Request.self)
                    request?.id = document.documentID
                    if let request = request {
                        group.enter()
                        self.fetchProfileImage(for: request.authorUID) {
                            group.leave()
                        }
                    }
                    return request
                }
                group.notify(queue: .main) {
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchRequestPublication(withId id: String) {
        isPublicationLoading = true
        
        let db = Firestore.firestore()
        
        db.collection("requests").document(id).getDocument { document, error in
            if let error = error {
                print("DEBUG: Error getting request: \(error)")
            } else if let document = document, document.exists, let request = try? document.data(as: Request.self) {
                // Update the fields with the fetched request data
                self.cirurgia = request.cirurgia
                self.acidente = request.acidente
                self.doenca = request.doenca
                self.tratamento = request.tratamento
                self.outro = request.outro
                self.additionalInfo = request.additionalInfo
                self.hemocentro = request.hemocentro
            } else {
                print("DEBUG: Document does not exist")
            }
        }
        self.isPublicationLoading = false
    }
}
