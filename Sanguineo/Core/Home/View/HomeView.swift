//
//  HomeView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var requestViewModel: RequestViewModel
    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel
    
    @StateObject var navigationBarViewModel = NavigationBarViewModel()
    
    var body: some View {
        if !initialLogViewModel.isLoggedIn {
            if homeViewModel.isTutorialActive {
                TutorialView()
            } else {
                InitialLogView(initialLogViewModel: initialLogViewModel)
            }
        } else {
            NavigationBarView(viewModel: navigationBarViewModel)
                .onAppear {
                    settingsViewModel.applyTheme(theme: settingsViewModel.theme)
                }
                .onReceive(initialLogViewModel.$publishedCurrentUserUID) { currentUserUID in
                    if let uid = currentUserUID {
                        requestViewModel.fetchRequests(for: uid)
                        appointmentsViewModel.fetchAppointments(for: uid)
                    }
                }
        }
//
//        NavigationBarView(viewModel: navigationBarViewModel)
//            .onAppear {
//                settingsViewModel.applyTheme(theme: settingsViewModel.theme)
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
            .environmentObject(InitialLogViewModel())
            .environmentObject(SettingsViewModel())
    }
}
