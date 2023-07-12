//
//  UserService.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 25/05/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

class UserService: ObservableObject {
    static let shared = UserService()
    @Published var user: User?
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let data = snapshot.data() else { return }
            
            if let uid = data["uid"] as? String,
               let fullname = data["fullname"] as? String,
               let fakename = data["fakename"] as? String,
               let email = data["email"] as? String,
               let password = data["password"] as? String,
               let addressCEP = data["addressCEP"] as? String,
               let addressSt = data["addressSt"] as? String,
               let addressNumber = data["addressNumber"] as? String,
               let complement = data["complement"] as? String,
               let phonenum = data["phonenum"] as? String,
               let bloodtype = data["bloodtype"] as? String,
               let identityID = data["identityID"] as? String,
               let age = data["age"] as? String,
               let gender = data["gender"] as? String,
               let dateOfBirth = data["dateOfBirth"] as? Timestamp {
                
                let location = data["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                let userLocation = User.Location(latitude: location.latitude, longitude: location.longitude)
                
                let user = User(uid: uid, fullname: fullname, fakename: fakename, email: email, password: password, addressCEP: addressCEP, addressSt: addressSt, addressNumber: addressNumber, complement: complement, phonenum: phonenum, bloodtype: bloodtype, identityID: identityID, age: age, gender: gender, dateOfBirth: dateOfBirth.dateValue(), location: userLocation)
                
                self.user = user
            } else {
                print("DEBUG: Error parsing user data to Swift properties fetchUser")
            }
        }
    }
    
    func updateUser(location: User.Location? = nil,
                    fullname: String? = nil,
                    fakename: String? = nil,
                    email: String? = nil,
                    addressCEP: String? = nil,
                    addressNeighborhood: String? = nil,
                    addressSt: String? = nil,
                    addressNumber: String? = nil,
                    complement: String? = nil,
                    phonenum: String? = nil,
                    bloodtype: String? = nil,
                    identityID: String? = nil,
                    age: String? = nil,
                    gender: String? = nil) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var updatedData: [String: Any] = [:]
        
        if let fullname = fullname { updatedData["fullname"] = fullname }
        if let fakename = fakename { updatedData["fakename"] = fakename }
        if let email = email { updatedData["email"] = email }
        if let addressCEP = addressCEP { updatedData["addressCEP"] = addressCEP }
        if let addressNeighborhood = addressNeighborhood { updatedData["addressNeighborhood"] = addressNeighborhood }
        if let addressSt = addressSt { updatedData["addressSt"] = addressSt }
        if let addressNumber = addressNumber { updatedData["addressNumber"] = addressNumber }
        if let complement = complement { updatedData["complement"] = complement }
        if let phonenum = phonenum { updatedData["phonenum"] = phonenum }
        if let bloodtype = bloodtype { updatedData["bloodtype"] = bloodtype }
        if let identityID = identityID { updatedData["identityID"] = identityID }
        if let age = age { updatedData["age"] = age }
        if let gender = gender { updatedData["gender"] = gender }
        if let location = location {
            updatedData["location"] = GeoPoint(latitude: location.latitude, longitude: location.longitude)
        }
        
        // Only attempt an update if there is data to update
        if !updatedData.isEmpty {
            Firestore.firestore().collection("users").document(uid).updateData(updatedData) { err in
                if let err = err {
                    print("DEBUG: Error updating document: \(err)")
                }
            }
        }
    }
    
    func fetchUserAndDo(completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let data = snapshot.data() else { return }
            
            if let uid = data["uid"] as? String,
               let fullname = data["fullname"] as? String,
               let fakename = data["fakename"] as? String,
               let email = data["email"] as? String,
               let password = data["password"] as? String,
               let addressCEP = data["addressCEP"] as? String,
               let addressSt = data["addressSt"] as? String,
               let addressNumber = data["addressNumber"] as? String,
               let complement = data["complement"] as? String,
               let phonenum = data["phonenum"] as? String,
               let bloodtype = data["bloodtype"] as? String,
               let identityID = data["identityID"] as? String,
               let age = data["age"] as? String,
               let gender = data["gender"] as? String,
               let dateOfBirth = data["dateOfBirth"] as? Timestamp {
                
                let location = data["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                let userLocation = User.Location(latitude: location.latitude, longitude: location.longitude)
                
                let user = User(uid: uid, fullname: fullname, fakename: fakename, email: email, password: password, addressCEP: addressCEP, addressSt: addressSt, addressNumber: addressNumber, complement: complement, phonenum: phonenum, bloodtype: bloodtype, identityID: identityID, age: age, gender: gender, dateOfBirth: dateOfBirth.dateValue(), location: userLocation)
                
                self.user = user
                completion()
            } else {
                print("DEBUG: Error parsing user data to Swift properties fetchUserAndDo")
            }
        }
    }
}
