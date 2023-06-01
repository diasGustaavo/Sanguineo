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
    @Published var bloodType: String
    @Published var age: Int
    
    init(image: Image, name: String, bloodType: String, age: Int) {
        self.image = image
        self.name = name
        self.bloodType = bloodType
        self.age = age
    }
}
