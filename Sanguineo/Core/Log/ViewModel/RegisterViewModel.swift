//
//  RegisterViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 23/05/23.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var selectedTab: Int
    @Published var name: String
    @Published var email: String
    @Published var password1: String
    @Published var password2: String
    @Published var phonenum: String
    @Published var isCheckedForm: Bool
    @Published var isCheckedEmail: Bool
    @Published var isCameraAuthorized: Bool
    
    init(selectedTab: Int = 0, name: String = "", email: String = "", password1: String = "", password2: String = "", phonenum: String = "", isCheckedForm: Bool = false, isCheckedEmail: Bool = false, isCameraAuthorized: Bool = false) {
        self.selectedTab = selectedTab
        self.name = name
        self.email = email
        self.password1 = password1
        self.password2 = password2
        self.phonenum = phonenum
        self.isCheckedForm = isCheckedForm
        self.isCheckedEmail = isCheckedEmail
        self.isCameraAuthorized = isCameraAuthorized
    }
}
