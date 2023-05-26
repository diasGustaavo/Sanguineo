//
//  User.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 25/05/23.
//

import Foundation

struct User: Codable, Hashable {
    let uid: String
    let fullname: String
    let fakename: String
    let email: String
    let password: String
    let addressCEP: String
    let addressSt: String
    let addressNumber: String
    let phonenum: String
    let bloodtype: String
    let identityID: String
    let age: String
}

extension User {
    static let example = User(uid: NSUUID().uuidString, fullname: "guga dias", fakename: "cassia eler", email: "ghmd196@gmail.com", password: "12345678", addressCEP: "58073345", addressSt: "rua emp manuel de brito", addressNumber: "304", phonenum: "83981474782", bloodtype: "O-", identityID: "6969", age: "23")
}
