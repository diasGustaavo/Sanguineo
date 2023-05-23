//
//  LoginView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 18/05/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    @ObservedObject var loginModel: LoginViewModel
    
    var body: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    
                    Spacer()
                        .frame(height: 28)
                    
                    // HEADER
                    VStack {
                        Image(uiImage: UIImage(named: "logoBig")!)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        Text("SanguiNeo")
                            .foregroundColor(Color(uiColor: UIColor(named: "brandColor")!))
                            .font(.system(size: 24))
                    }
                    .padding(.horizontal, 16)
                    
                    
                    Spacer().frame(height: 100)
                    
                    // TEXTFIELDS
                    Group {
                        ResponsiveCustomTextField(id: 1, scrollViewProxy: scrollViewProxy, content: $loginModel.email, placeholder: "Email")
                            .padding(.horizontal)
                        
                        CustomTextField(content: $loginModel.password, logo: "lock", placeholder: "Senha")
                            .padding()
                    }
                    
                    HStack {
                        Button(action: {
                            loginModel.isChecked.toggle()
                        }) {
                            HStack {
                                Image(systemName: loginModel.isChecked ? "checkmark.square" : "square")
                                    .font(.system(size: 13))
                                    .foregroundColor(.accentColor)
                                
                                Text("Lembre de mim")
                                    .font(.custom("Nunito-Light", size: 13))
                                    .foregroundColor(.accentColor)
                                
                                Spacer()
                            }
                        }
                        
                        Button(action: {
                            // some action
                        }) {
                            HStack {
                                Text("Esqueceu a senha?")
                                    .font(.custom("Nunito-Light", size: 13))
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: 100)
                    
                    Button {
                        // some action
                    } label: {
                        Text("Entrar")
                            .bold()
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(UIColor(named: "AccentColor")!))
                            .cornerRadius(7)
                            .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Não possui um conta?")
                            .font(.custom("Nunito-Light", size: 18))
                        
                        Button {
                            initialLogViewModel.isLoginViewActive = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                initialLogViewModel.isRegisterViewActive = true
                            }
                        } label: {
                            Text("Cadastre-se!")
                                .font(.custom("Nunito-Light", size: 18))
                                .foregroundColor(Color.accentColor)
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                        .frame(height: 20)
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginModel: LoginViewModel())
            .environmentObject(InitialLogViewModel())
    }
}
