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

enum AppointmentsScreens: String {
    case home = "Home"
    case newAppointment = "newAppointment"
}

class NavigationBarViewModel: ObservableObject {
    @Published var selectedTab: NavigationTab = .home
    @Published var selectedScreenAppointments: AppointmentsScreens = .home
}
