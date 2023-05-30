//
//  HomeView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var initialLogViewModel = InitialLogViewModel()
    
    var body: some View {
        if !initialLogViewModel.isLoggedIn {
            if homeViewModel.isTutorialActive {
                TutorialView()
                    .environmentObject(homeViewModel)
            } else {
                InitialLogView(initialLogViewModel: initialLogViewModel)
                    .environmentObject(homeViewModel)
            }
        } else {
            Button {
                withAnimation {
                    initialLogViewModel.signout()
                }
            } label: {
                Text("App")
            }
//            InitialLogView(initialLogViewModel: initialLogViewModel)
//                .environmentObject(homeViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
