//
//  SanguineoApp.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI

@main
struct SanguineoApp: App {
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeViewModel)
        }
    }
}
