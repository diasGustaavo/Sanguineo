//
//  RequestView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 09/06/23.
//

import SwiftUI
import SwiftUIPullToRefresh

struct RequestView: View {
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    @EnvironmentObject var profile: ProfileViewModel
    
    @EnvironmentObject var viewModel: RequestViewModel
    
    let genderOptions = ["Masculino", "Feminino", "Outros"]
    
    var body: some View {
        NavigationView {
            RefreshableScrollView(onRefresh: { done in
                if let currentUserUID = initialLogViewModel.currentUser?.uid {
                    viewModel.fetchRequestsAndDo(for: currentUserUID) {
                        done()
                    }
                } else {
                    done()
                }
            },
                                  progress: { state in
                if state == .waiting {
                    // empty view
                } else {
                    Spinner(lineWidth: 5, height: 32, width: 32)
                }
            }) {
                VStack {
                    HStack {
                        if viewModel.isLoading {
                            Spinner(lineWidth: 5, height: 32, width: 32)
                                .frame(width: 80, height: 80)
                                .padding(.leading)
                        } else {
                            Image(uiImage: viewModel.profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.leading)
                        }
                        
                        Text(profile.name)
                            .lineLimit(1)
                            .font(.custom("Nunito-SemiBold", size: 22))
                            .padding()
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    HStack {
                        Text("Suas principais informações")
                            .font(.custom("Nunito-Light", size: 16))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Nome: \(profile.name) / Sangue: \(profile.bloodtype) / Gênero: \(profile.genderName) / Número: \(profile.phone)")
                            .font(.custom("Nunito-Light", size: 16))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Suas Solicitações")
                            .font(.custom("Nunito-SemiBold", size: 22))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding()
                    
                    if !viewModel.isLoading {
                        ForEach(viewModel.requests, id: \.self) { req in
                            NavigationLink {
                                MakeRequestView(requestID: req.id ?? "", viewModel: viewModel)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    if let data = viewModel.profileImagesData[req.authorUID], let image = UIImage(data: data) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenWidth * 0.2)
                                            .cornerRadius(90)
                                    } else {
                                        Image(uiImage: UIImage(named: "3davatar2")!)
                                            .resizable()
                                            .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenWidth * 0.2)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("Principais informações do agendamento")
                                        .font(.custom("Nunito-Light", size: 16))
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "pencil")
                                }
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.accentColor, lineWidth: 0.8)
                                )
                                .padding(.horizontal)
                                .padding(.top, 8)
                            }
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                        }
                    } else {
                        VStack {
                            Spacer()
                                .frame(height: 40)
                            
                            Spinner(lineWidth: 5, height: 32, width: 32)
                            
                            Spacer()
                                .frame(height: 20)
                        }
                    }
                    
                    NavigationLink {
                        MakeRequestView(requestID: "", viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack {
                            Text("Nova solicitação")
                            
                            Image(systemName: "plus.circle")
                        }
                        .font(.custom("Nunito-SemiBold", size: 22))
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                        .padding()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
            .environmentObject(InitialLogViewModel())
            .environmentObject(ProfileViewModel())
    }
}
