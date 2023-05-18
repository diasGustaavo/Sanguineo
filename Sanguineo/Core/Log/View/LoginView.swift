//
//  LoginView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 18/05/23.
//

import SwiftUI

struct LoginView: View {
    @State var email: String
    @State private var isChecked = false
    
    var body: some View {
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
            
            
            Spacer()
            
            // TEXTFIELDS
            Group {
                CustomTextField(content: $email, placeholder: "Email")
                    .padding(.horizontal)
                
                CustomTextField(content: $email, logo: "lock", placeholder: "Password")
                    .padding()
            }
            
            HStack {
                Button(action: {
                    isChecked.toggle()
                }) {
                    HStack {
                        Image(systemName: isChecked ? "checkmark.square" : "square")
                            .font(.system(size: 13))
                            .foregroundColor(.accentColor)
                        
                        Text("Lembre de mim")
                            .font(.custom("Nunito-Light", size: 13))
                            .foregroundColor(.accentColor)
                        
                        Spacer()
                    }
                }
                
                Button(action: {
                    isChecked.toggle()
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
                .frame(height: 40)
            
            Button {
                // some action
            } label: {
                Text("Entre")
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
                    // some action
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(email: "")
    }
}
