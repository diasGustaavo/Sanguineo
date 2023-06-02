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
    @StateObject private var profileViewModel = ProfileViewModel(
        image: Image("3davatar2"),
        name: "John Doe",
        bloodType: "A+",
        age: 30
    )

    var body: some View {
        VStack {
            Spacer() // This will push the rest of the content to the bottom
            
            switch viewModel.selectedTab {
            case .home:
                FeedView(navigationBarViewModel: viewModel)
            case .appointments:
                switch viewModel.selectedScreenAppointments {
                case .home:
                    AppointmentsView()
                case .newAppointment:
                    if viewModel.selectedScreenAppointments == .newAppointment {
                        withAnimation {
                            DonateView(image: image, name: name, bloodtype: bloodtype, description: description, nationality: nationality, navigationBarViewModel: viewModel) {
                                // some action
                            }
                            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                        }
                    }
                }
            case .profile:
                ProfileView(profile: profileViewModel)
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
