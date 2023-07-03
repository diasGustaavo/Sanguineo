//
//  Address.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 03/07/23.
//

import Foundation

struct Address: Codable, Hashable {
    let street: String?
    let number: String?
    let neighborhood: String?
    let city: String?
    let state: String?
    let coordinateX: Double
    let coordinateY: Double
}
