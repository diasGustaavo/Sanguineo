//
//  EditProfileInfoView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 02/06/23.
//

import SwiftUI

struct EditProfileInfoView: View {
    @EnvironmentObject var profile: ProfileViewModel
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
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
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
                    EditNameView(name: $profile.name)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "person", buttonText: "Nome")
                }
                
                NavigationLink {
                    EditSocialNameView(name: $profile.fakeName)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "theatermasks", buttonText: "Nome Social")
                }
                
                NavigationLink {
                    EditEmailView(email: $profile.email)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "envelope", buttonText: "E-mail")
                }
                
                NavigationLink {
                    EditPhoneView(phone: $profile.phone)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "phone", buttonText: "Telefone")
                }
                
                NavigationLink {
                    EditAddressView(CEP: $profile.CEP, neighborhood: $profile.neighborhood, street: $profile.street, number: $profile.number, complement: $profile.complement)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "mappin.and.ellipse", buttonText: "Endereço")
                }
                
                NavigationLink {
                    AboutBloodtypesView()
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "drop", buttonText: "Tipos Sanguíneos")
                }
                
                NavigationLink {
                    EditGenderView(selectedGender: $profile.gender)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "hand.raised.square.on.square", buttonText: "Gênero")
                }

                Spacer()
            }
        }
    }
}

struct EditProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileInfoView()
    }
}
