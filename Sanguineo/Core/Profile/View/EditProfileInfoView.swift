//
//  EditProfileInfoView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 02/06/23.
//

import SwiftUI

struct EditProfileInfoView: View {
    
    @Binding var name: String
    @Binding var fakeName: String
    @Binding var email: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Nunito-Semibold", size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    
                    Text("Perfil")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                
                NavigationLink {
                    EditNameView(name: $name)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "person", buttonText: "Editar nome")
                }
                
                NavigationLink {
                    EditSocialNameView(name: $name)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "theatermasks", buttonText: "Editar nome social")
                }
                
                NavigationLink {
                    EditEmailView(email: $email)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "envelope", buttonText: "Editar e-mail")
                }
                
                CustomButtonCell(leftSymbol: "phone", buttonText: "Editar telefone") {
                    // some action
                }
                CustomButtonCell(leftSymbol: "mappin.and.ellipse", buttonText: "Editar endereço") {
                    // some action
                }
                CustomButtonCell(leftSymbol: "drop", buttonText: "Editar tipo sanguíneo") {
                    // some action
                }
                CustomButtonCell(leftSymbol: "hand.raised.square.on.square", buttonText: "Editar gênero") {
                    // some action
                }
                
                Spacer()
            }
        }
    }
}

struct EditProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileInfoView(name: Binding.constant("guga dias"), fakeName: Binding.constant("liz taylor"), email: Binding.constant("diasgustaavo@icloud.com"))
    }
}
