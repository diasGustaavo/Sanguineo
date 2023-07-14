//
//  ProfileViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 01/06/23.
//

import SwiftUI
import Combine
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    @Published var image: UIImage
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
    
    @Published var isLoading = false
    
    let genderOptions = ["Masculino", "Feminino", "Outros"]
    
    private let storage = Storage.storage()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.image = UIImage(named: "3d_avatar_28")!
        
        UserService.shared.$user
            .sink { [weak self] in
                self?.updateUser($0)
                if let userID = $0?.uid {
                    self?.fetchImage(for: userID)
                }
            }
            .store(in: &cancellables)
    }
    
    func updateUser(_ user: User?) {
        isLoading = true
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
    
    func updateImage(userID: String) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        
        let imageRef = Storage.storage().reference().child("profileImages/\(userID).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error)")
            } else {
                print("Successfully uploaded image.")
            }
        }
    }
    
    func fetchImage(for userID: String) {
        let imagePath = "profileImages/\(userID).jpg"
        let storageReference = storage.reference()
        
        storageReference.child(imagePath).getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching profile image: \(error)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    self.isLoading = false
                }
            }
        }
    }
}
