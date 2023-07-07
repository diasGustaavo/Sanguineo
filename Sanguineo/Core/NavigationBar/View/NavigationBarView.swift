//
//  NavigationBarView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI

struct NavigationBarView: View {
    let image = UIImage(named: "3d_avatar_28")!
    let name = "Luciano Araujo"
    let bloodtype = "O-"
    let age = 22
    let description = "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro."
    let nationality = "Brasileira"
    
    let imageHospital = UIImage(named: "3d_avatar_28_hospital")!
    let nameHospital = "Hemocentro"
    let bloodtypeHospital = "O-"
    let descriptionHospital = "Precisamos urgente de sangue O+ para inúmeros pacientes"
    
    @ObservedObject var viewModel: NavigationBarViewModel
    
    var body: some View {
        VStack {
            Spacer() // This will push the rest of the content to the bottom
            
            switch viewModel.selectedTab {
            case .home:
                FeedView(navigationBarViewModel: viewModel)
            case .appointments:
                AppointmentsView(navigationBarViewModel: viewModel)
            case .profile:
                ProfileView()
            case .request: // New case added
                RequestView()
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
                            
                            Text("Início")
                                .font(.system(size: 12))
                        }
                    }.foregroundColor(viewModel.selectedTab == .home ? .accentColor : Color(uiColor: UIColor(named: "frontColor")!))
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
                            
                            Text("Agendamentos")
                                .font(.system(size: 12))
                        }
                    }.foregroundColor(viewModel.selectedTab == .appointments ? .accentColor : Color(uiColor: UIColor(named: "frontColor")!))
                }
                
                Spacer()
                
                VStack {
                    if viewModel.selectedTab == .request {
                        Rectangle().frame(width: 30, height: 2).foregroundColor(.accentColor)
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Button(action: { viewModel.selectedTab = .request }) {
                        VStack {
                            Image(systemName: "doc.text") // Replace this with the desired image for the new tab
                            
                            Spacer().frame(height: 5)
                            
                            Text("Solicitação")
                                .font(.system(size: 12))
                        }
                    }.foregroundColor(viewModel.selectedTab == .request ? .accentColor : Color(uiColor: UIColor(named: "frontColor")!))
                }
                .padding(.horizontal)
                
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
                            
                            Text("Perfil")
                                .font(.system(size: 12))
                        }
                    }.foregroundColor(viewModel.selectedTab == .profile ? .accentColor : Color(uiColor: UIColor(named: "frontColor")!))
                }
                .padding(.horizontal)
                
                Spacer().frame(width: 20)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use StackNavigationViewStyle for consistent behavior across devices
        .ignoresSafeArea(.keyboard)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(viewModel: NavigationBarViewModel())
    }
}
