//
//  ProfileViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 01/06/23.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var image: Image
    @Published var name: String
    @Published var fakeName: String
    @Published var email: String
    @Published var phone: String
    @Published var CEP: String
    @Published var neighborhood: String
    @Published var street: String
    @Published var number: String
    @Published var complement: String
    @Published var gender: Int
    @Published var bloodtype: String

    init(image: Image, name: String, fakeName: String, email: String, phone: String, CEP: String, neighborhood: String, street: String, number: String, complement: String, gender: Int, bloodtype: String) {
        self.image = image
        self.name = name
        self.fakeName = fakeName
        self.email = email
        self.phone = phone
        self.CEP = CEP
        self.neighborhood = neighborhood
        self.street = street
        self.number = number
        self.complement = complement
        self.gender = gender
        self.bloodtype = bloodtype
    }
}
