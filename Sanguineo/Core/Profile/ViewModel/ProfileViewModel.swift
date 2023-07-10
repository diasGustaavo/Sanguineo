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
    @Published var name: String = ""
    @Published var fakeName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var CEP: String = ""
    @Published var neighborhood: String = ""
    @Published var street: String = ""
    @Published var number: String = ""
    @Published var complement: String = ""
    @Published var gender: Int = 0
    @Published var genderName: String = ""
    @Published var bloodtype: String = ""
    
    let genderOptions = ["Masculino", "Feminino", "Outros"]
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.image = Image(uiImage: UIImage(named: "3d_avatar_28")!)
        
        UserService.shared.$user
            .sink { [weak self] in self?.updateUser($0) }
            .store(in: &cancellables)
    }
    
    func updateUser(_ user: User?) {
        self.name = user?.fullname ?? ""
        self.fakeName = user?.fakename ?? ""
        self.email = user?.email ?? ""
        self.phone = user?.phonenum ?? ""
        self.CEP = user?.addressCEP ?? ""
        self.neighborhood = user?.addressSt ?? ""
        self.street = user?.addressSt ?? ""
        self.number = "\(user?.addressNumber ?? "")"
        self.complement = user?.complement ?? ""
        self.bloodtype = user?.bloodtype ?? ""
        self.genderName = user?.gender ?? ""
        
        self.gender = Int(user?.gender ?? "0") ?? 0
        self.genderName = genderOptions[self.gender]
    }
}
