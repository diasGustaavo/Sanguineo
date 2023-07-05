//
//  FeedViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/07/23.
//

import UIKit

protocol RequesterInfo {
    var image: UIImage { get }
    var name: String { get }
    var bloodtype: String { get }
    var description: String { get }
}

struct Individual: Identifiable, Hashable, RequesterInfo {
    let id = UUID()
    let image: UIImage
    let name: String
    let bloodtype: String
    let age: Int
    let description: String
}

struct Hospital: Identifiable, Hashable, RequesterInfo {
    let id = UUID()
    let image: UIImage
    let name: String
    let bloodtype: String
    let description: String
}

class FeedViewModel: ObservableObject {
    let individuals: [Individual] = (0..<5).map { _ in
        Individual(image: UIImage(named: "3d_avatar_28")!,
                   name: "Luciano Araujo",
                   bloodtype: "O-",
                   age: 22,
                   description: "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro.")
    }
    
    let hospitals: [Hospital] = (0..<5).map { _ in
        Hospital(image: UIImage(named: "3d_avatar_28_hospital")!,
                 name: "Hemocentro",
                 bloodtype: "O-",
                 description: "Precisamos urgente de sangue O+ para inúmeros pacientes")
    }
}
