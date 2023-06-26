//
//  MakeRequestViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 26/06/23.
//

import Foundation

class MakeRequestViewModel: ObservableObject {
    @Published var cirurgia: Bool = false
    @Published var acidente: Bool = false
    @Published var doenca: Bool = false
    @Published var tratamento: Bool = false
    @Published var outro: Bool = false
    @Published var additionalInfo: String = ""
    @Published var hemocentro: String = ""
}
