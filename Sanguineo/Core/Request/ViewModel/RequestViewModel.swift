//
//  RequestViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 26/06/23.
//

import FirebaseFirestore

class RequestViewModel: ObservableObject {
    @Published var cirurgia: Bool = false
    @Published var acidente: Bool = false
    @Published var doenca: Bool = false
    @Published var tratamento: Bool = false
    @Published var outro: Bool = false
    @Published var additionalInfo: String = ""
    @Published var hemocentro: String = ""
    @Published var requests = [Request]()
    
    @Published var isLoading = true
    @Published var isPublicationLoading = false
    
    func saveRequest(authorUID: String, reqUID: String = "") {
        let request = Request(id: nil, cirurgia: cirurgia, acidente: acidente, doenca: doenca, tratamento: tratamento, outro: outro, additionalInfo: additionalInfo, hemocentro: hemocentro, authorUID: authorUID, date: Date())
        
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
                        print("DEBUG: Request successfully added!")
                        self.resetFields()
                    }
                }
            } else {
                // If reqUID is not empty, update the existing document with the reqUID
                db.collection("requests").document(reqUID).setData(requestDocument) { error in
                    if let error = error {
                        print("DEBUG: Error updating request: \(error)")
                    } else {
                        print("DEBUG: Request successfully updated!")
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

    func fetchRequests(for authorUID: String) {
        isLoading = true
        let db = Firestore.firestore()
        db.collection("requests").whereField("authorUID", isEqualTo: authorUID).getDocuments { querySnapshot, error in
            if let error = error {
                print("DEBUG: Error getting requests: \(error)")
            } else if let querySnapshot = querySnapshot {
                self.requests = querySnapshot.documents.compactMap { document -> Request? in
                    var request = try? document.data(as: Request.self)
                    request?.id = document.documentID
                    self.isLoading = false
                    return request
                }
            }
        }
        self.isLoading = false
    }
    
    func fetchRequest(withId id: String) {
        isLoading = true
        
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
                self.isLoading = false
            } else {
                print("DEBUG: Document does not exist")
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
