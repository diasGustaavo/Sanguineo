//
//  HomeView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        InitialLogView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
