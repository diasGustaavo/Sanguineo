//
//  InitialLogView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 23/05/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

class InitialLogViewModel: ObservableObject {
    @Published var isLoginViewActive: Bool = false
    @Published var isRegisterViewActive: Bool = false
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false

    private var handle: AuthStateDidChangeListenerHandle?
    
    public var currentUserUID: String? {
        return currentUser?.uid
    }
    
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isLoggedIn = user != nil
        }
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let e = error {
                print("DEBUG: Failed to sign in with error: \(e.localizedDescription)")
                return
            }
            self.userSession = result?.user
            UserService.shared.fetchUserAndDo {
                self.fetchUser()
            }
        }
    }
    
    func registerUser(
        fullname: String = "",
        fakename: String = "",
        email: String,
        password: String,
        addressCEP: String = "",
        addressSt: String = "",
        addressNumber: String = "",
        phonenum: String,
        bloodtype: String = "",
        identityID: String = "",
        age: String = ""
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let e = error {
                print("DEBUG: Failed to sign up with error: \(e.localizedDescription)")
                return
            }
            
            guard let firebaseUser = result?.user else {
                print("DEBUG: error getting firebase user")
                return
            }
            self.userSession = firebaseUser
            self.service.fetchUserAndDo {
                self.fetchUser()
            }
            
            let user = User(uid: firebaseUser.uid, fullname: fullname, fakename: fakename, email: email, password: password, addressCEP: addressCEP, addressSt: addressSt, addressNumber: addressNumber, phonenum: phonenum, bloodtype: bloodtype, identityID: identityID, age: age)
            self.currentUser = user
            
            do {
                let encodedUser = try Firestore.Encoder().encode(user)
                Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)

                Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser) { error in
                    if let error = error {
                        print("DEBUG: Error writing document: \(error)")
                    } else {
                        print("DEBUG: Document successfully written!")
                    }
                }
            } catch {
                print("DEBUG: Encoding error: \(error)")
            }
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            UserService.shared.user = nil
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    // FETCH USER FUNCTION W/O COMBINE
    
//    func fetchUser() {
//        UserService().fetchUser { user in
//            self.currentUser = user
//        }
//    }
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
            }
            .store(in: &cancellables)

    }
}
