//
//  LoginViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 18/05/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String
    @Published var password: String
    @Published var isChecked: Bool
    
    init(email: String = "", password: String = "", isChecked: Bool = false) {
        self.email = email
        self.password = password
        self.isChecked = isChecked
    }
}
