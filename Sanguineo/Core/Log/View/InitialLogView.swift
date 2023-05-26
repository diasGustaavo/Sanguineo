//
//  InitialLogView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI

struct InitialLogView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @ObservedObject var initialLogViewModel: InitialLogViewModel
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            // HEADER
            HStack {
                Image(uiImage: UIImage(named: "sanguineoLogo")!)
                
                Spacer()
                    .frame(width: 10)
                
                Text("SanguiNeo")
                    .foregroundColor(Color(uiColor: UIColor(named: "brandColor")!))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            
            Spacer()
                .frame(height: 18)
            
            Image(uiImage: UIImage(named: "pose_6")!)
            
            Spacer()
                .frame(height: 18)
            
            Group {
                Text("Olá!")
                    .font(.custom("Nunito-SemiBold", size: 20))

                Text("O SanguiNeo é um aplicativo que permite agendar e realizar doações de sangue, incentivando os usuários com recompensas digitais.")
                    .font(.custom("Nunito-Light", size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 16)
            }
            .padding(.horizontal, 16)
            
            HStack {
                Button {
                    initialLogViewModel.isLoginViewActive = true
                } label: {
                    Text("Entre")
                        .bold()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                }
                
                Spacer()
                    .frame(width: 15)
                
                Button {
                    initialLogViewModel.isRegisterViewActive = true
                } label: {
                    Text("Cadastre-se")
                        .bold()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor(named: "AccentColor")!))
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.blue, lineWidth: 2)
                            )
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
                .frame(height: 15)
            
            Text("Ou entre com suas redes")
                .padding()
                .font(.custom("Nunito-SemiBold", size: 16))
            
            HStack {
                Button {
                    // some action
                } label: {
                    Image(uiImage: UIImage(named: "facebookLogo")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .padding(.horizontal, 12)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(height: 40)
                }
                
                Spacer()
                    .frame(width: 15)
                
                Button {
                    // some action
                } label: {
                    Image(uiImage: UIImage(named: "googleLogo")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .padding(.horizontal, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                        .frame(height: 40)
                }
                
                Spacer()
                    .frame(width: 15)

                Button {
                    // some action
                } label: {
                    Image(uiImage: UIImage(named: "instagramLogo")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .padding(.horizontal, 8)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(height: 40)
                }
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $initialLogViewModel.isLoginViewActive) {
            LoginView(loginModel: loginViewModel)
                .environmentObject(initialLogViewModel)
        }
        .fullScreenCover(isPresented: $initialLogViewModel.isRegisterViewActive) {
            RegisterView()
                .environmentObject(initialLogViewModel)
        }
    }
}

struct InitialLogView_Previews: PreviewProvider {
    static var previews: some View {
        InitialLogView(initialLogViewModel: InitialLogViewModel())
    }
}
