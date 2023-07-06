//
//  RegisterViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 23/05/23.
//

import UIKit

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
    @Published var selectedImage: UIImage? = UIImage(named: "3davatar2")! // temporary
    @Published var selectedBlood: Int
    @Published var dateOfBirth: Date
    
    let bloodTypes = ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"]
    
    func getSelectedBloodType() -> String {
        guard bloodTypes.indices.contains(selectedBlood) else {
            fatalError("Index \(selectedBlood) is out of bounds for options array of size \(bloodTypes.count).")
        }
        return bloodTypes[selectedBlood]
    }
    
    init(selectedTab: Int = 0, name: String = "", email: String = "", password1: String = "", password2: String = "", phonenum: String = "", isCheckedForm: Bool = false, isCheckedEmail: Bool = false, isCameraAuthorized: Bool = false, selectedBlood: Int = 0, dateOfBirth: Date = Date()) {
        self.selectedTab = selectedTab
        self.name = name
        self.email = email
        self.password1 = password1
        self.password2 = password2
        self.phonenum = phonenum
        self.isCheckedForm = isCheckedForm
        self.isCheckedEmail = isCheckedEmail
        self.isCameraAuthorized = isCameraAuthorized
        self.selectedBlood = selectedBlood
        self.dateOfBirth = dateOfBirth
    }
}
