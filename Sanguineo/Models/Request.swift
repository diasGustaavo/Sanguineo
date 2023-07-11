//
//  Request.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 27/06/23.
//

import Foundation

struct Request: Codable, Hashable {
    var id: String? // the ID of the Firestore document
    var cirurgia: Bool
    var acidente: Bool
    var doenca: Bool
    var tratamento: Bool
    var outro: Bool
    var additionalInfo: String
    var hemocentro: String
    var authorUID: String
    var date: Date
}
