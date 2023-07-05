//
//  FeedView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
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
                        DetailedFeedCategoryView(sectionDescription: "Essas pessoas precisam de sua ajuda", requesters: feedViewModel.individuals) {
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
                
                
                if !feedViewModel.individualsLoading {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(feedViewModel.individuals, id: \.self) { individual in
                                ReusablePersonCellView(image: UIImage(named: "3d_avatar_28")!, name: individual.name, bloodtype: individual.bloodtype, age: individual.age, description: individual.description) {
                                    print("button 1 pressed")
                                    navigationBarViewModel.selectedTab = .appointments
                                    navigationBarViewModel.selectedScreenAppointments = .newAppointment
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding(.leading, 16)
                } else {
                    VStack {
                        Spacer()
                            .frame(height: 40)
                        
                        Spinner(lineWidth: 5, height: 32, width: 32)
                        
                        Spacer()
                            .frame(height: 20)
                    }
                }
                
                HStack {
                    Text("Campanhas de doações")
                        .font(.custom("Nunito-Bold", size: 18))
                        .multilineTextAlignment(.leading)
                    
                    Spacer().frame(width: 80)
                    
                    NavigationLink {
                        DetailedFeedCategoryView(sectionDescription: "Campanhas de doações", requesters: feedViewModel.hospitals) {
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
                        ForEach(feedViewModel.hospitals, id: \.self) { hospital in
                            ReusablePersonCellView(image: hospital.image, name: hospital.name, bloodtype: hospital.bloodtype, age: nil, description: hospital.description) {
                                print("button 2 pressed")
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
            .environmentObject(FeedViewModel())
    }
}
