//
//  NavigationBarView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI

struct NavigationBarView: View {
    @ObservedObject var viewModel: NavigationBarViewModel

    var body: some View {
        VStack {
            Spacer() // This will push the rest of the content to the bottom
            
            switch viewModel.selectedTab {
            case .home:
                FeedView()
            case .appointments:
                AppointmentsView()
            case .profile:
                ProfileView()
            }
            HStack {
                Spacer().frame(width: 20)
                
                VStack {
                    if viewModel.selectedTab == .home {
                        Rectangle().frame(width: 30, height: 2).foregroundColor(.accentColor)
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Button(action: { viewModel.selectedTab = .home }) {
                        VStack {
                            Image(systemName: "house")
                            
                            Spacer().frame(height: 5)
                            
                            Text("Home")
                                .font(.system(size: 12))
                        }
                    }.foregroundColor(viewModel.selectedTab == .home ? .accentColor : .black)
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack {
                    if viewModel.selectedTab == .appointments {
                        Rectangle().frame(width: 30, height: 2).foregroundColor(.accentColor)
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Button(action: { viewModel.selectedTab = .appointments }) {
                        VStack {
                            Image(systemName: "calendar")
                            
                            Spacer().frame(height: 5)
                            
                            Text("Appointments")
                                .font(.system(size: 12))
                        }
                    }.foregroundColor(viewModel.selectedTab == .appointments ? .accentColor : .black)
                }
                
                Spacer()
                
                VStack {
                    if viewModel.selectedTab == .profile {
                        Rectangle().frame(width: 30, height: 2).foregroundColor(.accentColor)
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Button(action: { viewModel.selectedTab = .profile }) {
                        VStack {
                            Image(systemName: "person.circle")
                            
                            Spacer().frame(height: 5)
                            
                            Text("Profile")
                                .font(.system(size: 12))
                        }
                    }.foregroundColor(viewModel.selectedTab == .profile ? .accentColor : .black)
                }
                .padding(.horizontal)
                
                Spacer().frame(width: 20)
            }
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(viewModel: NavigationBarViewModel())
    }
}
