//
//  HomeView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        if homeViewModel.isTutorialActive {
            TutorialView()
                .environmentObject(homeViewModel)
        } else if homeViewModel.isInitialLoginScreenActive {
            InitialLogView()
                .environmentObject(homeViewModel)
        } else {
            RegisterView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
