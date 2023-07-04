//
//  FeedView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI

struct FeedView: View {
    let image = UIImage(named: "3d_avatar_28")!
    let name = "Luciano Araujo"
    let bloodtype = "O-"
    let age = 22
    let description = "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro."
    
    let imageHospital = UIImage(named: "3d_avatar_28_hospital")!
    let nameHospital = "Hemocentro"
    let bloodtypeHospital = "O-"
    let descriptionHospital = "Precisamos urgente de sangue O+ para inúmeros pacientes"
    
    @ObservedObject var navigationBarViewModel: NavigationBarViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                // HEADER
                HStack {
                    Image(uiImage: UIImage(named: "bloodtype")!)
                        .resizable()
                        .frame(width: 30 ,height: 30)
                    
                    Text("O-")
                        .font(.custom("Nunito-Regular", size: 16))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("Rua Empresario Manoel...")
                        .font(.custom("Nunito-Light", size: 16))
                        .multilineTextAlignment(.center)
                    
                    Image(systemName: "chevron.down")
                        .font(.custom("Nunito-Light", size: 14))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Image(systemName: "bell")
                        .font(.custom("Nunito-Semibold", size: 20))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 16)
                
                // FILTERS
                HStack {
                    Button(action: {
                        // some action
                    }) {
                        HStack {
                            Image(systemName: "line.horizontal.3.decrease")
                                .padding(.leading)
                            
                            Text("Filtros")
                                .font(.custom("Nunito-Regular", size: 14))
                                .frame(height: 40)
                                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                                .padding(.trailing)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // some action
                    }) {
                        Text("Mais Próximos")
                            .font(.custom("Nunito-Regular", size: 14))
                            .multilineTextAlignment(.center)
                            .frame(height: 40)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                            )
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // some action
                    }) {
                        Text("Urgência")
                            .font(.custom("Nunito-Regular", size: 14))
                            .multilineTextAlignment(.center)
                            .frame(height: 40)
                            .padding(.horizontal)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 22)
                
                HStack {
                    Text("Essas pessoas precisam de sua ajuda")
                        .font(.custom("Nunito-Bold", size: 18))
                        .multilineTextAlignment(.leading)
                    
                    Spacer().frame(width: 100)
                    
                    NavigationLink {
                        DetailedFeedCategoryView(sectionDescription: "Essas pessoas precisam de sua ajuda", image: image, name: name, bloodtype: bloodtype, description: description, age: age) {
                            // some action
                        }
                    } label: {
                        Text("Expandir")
                            .font(.custom("Nunito-Regular", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<3) { _ in
                            ReusablePersonCellView(image: image, name: name, bloodtype: bloodtype, age: age, description: description) {
                                print("bota 1 pressionado")
                                navigationBarViewModel.selectedTab = .appointments
                                navigationBarViewModel.selectedScreenAppointments = .newAppointment
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.leading, 16)
                
                HStack {
                    Text("Campanhas de doações")
                        .font(.custom("Nunito-Bold", size: 18))
                        .multilineTextAlignment(.leading)
                    
                    Spacer().frame(width: 80)
                    
                    NavigationLink {
                        DetailedFeedCategoryView(sectionDescription: "Campanhas de doações", image: imageHospital, name: nameHospital, bloodtype: bloodtypeHospital, description: descriptionHospital, onButtonPress: {
                            // some action
                        })
                    } label: {
                        Text("Expandir")
                            .font(.custom("Nunito-Regular", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<3) { _ in
                            ReusablePersonCellView(image: imageHospital, name: nameHospital, bloodtype: bloodtypeHospital, age: nil, description: descriptionHospital) {
                                print("bota 2 pressionado")
                                navigationBarViewModel.selectedTab = .appointments
                                navigationBarViewModel.selectedScreenAppointments = .newAppointment
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.leading, 16)
            }
        }
        .navigationBarHidden(true)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(navigationBarViewModel: NavigationBarViewModel())
    }
}
