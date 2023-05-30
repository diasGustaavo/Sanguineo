//
//  NavigationBarViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import Foundation

enum NavigationTab: String {
    case home = "Home"
    case appointments = "Appointments"
    case profile = "Profile"
}

class NavigationBarViewModel: ObservableObject {
    @Published var selectedTab: NavigationTab = .home
}
