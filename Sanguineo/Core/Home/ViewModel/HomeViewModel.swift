//
//  HomeViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isTutorialActive = true
    @Published var isInitialLoginScreenActive = true
}
