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
               let phonenum = data["phonenum"] as? String,
               let bloodtype = data["bloodtype"] as? String,
               let identityID = data["identityID"] as? String,
               let age = data["age"] as? String {
                let user = User(uid: uid, fullname: fullname, fakename: fakename, email: email, password: password, addressCEP: addressCEP, addressSt: addressSt, addressNumber: addressNumber, complement: "A", phonenum: phonenum, bloodtype: bloodtype, identityID: identityID, age: age)
                self.user = user
            } else {
                print("DEBUG: Error parsing user data to Swift properties")
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
               let phonenum = data["phonenum"] as? String,
               let bloodtype = data["bloodtype"] as? String,
               let identityID = data["identityID"] as? String,
               let age = data["age"] as? String {
                let user = User(uid: uid, fullname: fullname, fakename: fakename, email: email, password: password, addressCEP: addressCEP, addressSt: addressSt, addressNumber: addressNumber, complement: "A", phonenum: phonenum, bloodtype: bloodtype, identityID: identityID, age: age)
                self.user = user
                completion()
            } else {
                print("DEBUG: Error parsing user data to Swift properties")
            }
        }
    }
    
    // FETCH USER FUNCTION W/O COMBINE
    
    //    static func fetchUser(completion: @escaping(User) -> Void) {
    //        guard let uid = Auth.auth().currentUser?.uid else { return }
    //
    //        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
    //            guard let snapshot = snapshot else { return }
    //
    //            guard let user = try? snapshot.data(as: User.self) else { return }
    //
    //            completion(user)
    //        }
    //    }
}
