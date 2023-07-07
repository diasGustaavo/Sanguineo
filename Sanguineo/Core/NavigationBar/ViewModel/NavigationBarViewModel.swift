//
//  NavigationBarViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import Foundation

enum NavigationTab: String {
    case home = "Início"
    case appointments = "Compromissos"
    case profile = "Perfil"
    case request = "Solicitação" // New tab
}

class NavigationBarViewModel: ObservableObject {
    @Published var selectedTab: NavigationTab = .home
}
