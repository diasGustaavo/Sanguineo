//
//  ProfileView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profile: ProfileViewModel
    @State private var isShowingImagePicker = false
    
    @State var name: String
    @State var fakeName: String
    @State var email: String
    @State var phone: String
    
    @State var CEP: String
    @State var neighborhood: String
    @State var street: String
    @State var number: String
    @State var complement: String
    
    @State var gender: Int
    
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ZStack(alignment: .topTrailing) {
                        profile.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(4)
                                .foregroundColor(.white)
                        }
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                        .padding(4)
                        .offset(x: 8, y: 50)
                        .opacity(isShowingImagePicker ? 0 : 1)
                    }
                    .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        Text(profile.name)
                            .lineLimit(1)
                            .font(.custom("Nunito-SemiBold", size: 18))
                        
                        HStack {
                            Image("bloodtype")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text("Tipo Sanguíneo:")
                                .font(.custom("Nunito-SemiBold", size: 15))
                            
                            Text(profile.bloodType)
                                .font(.custom("Nunito-Regular", size: 15))
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                NavigationLink {
                    EditProfileInfoView(name: $name, fakeName: $fakeName, email: $email, phone: $phone, CEP: $CEP, neighborhood: $neighborhood, street: $street, number: $number, complement: $complement, gender: $gender)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "person", buttonText: "Editar informações do perfil")
                }
                
                NavigationLink {
                    RewardsView()
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "star", buttonText: "Recompensas")
                }
                
                NavigationLink {
                    AddressView()
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "location", buttonText: "Configurar localização")
                }
                
                NavigationLink {
                    PermissionsView()
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "checkmark.circle", buttonText: "Permissões do app")
                }
                
                NavigationLink {
                    TermsView()
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "doc.plaintext", buttonText: "Termos de uso")
                }
                
                NavigationLink {
                    SettingsView()
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "gearshape", buttonText: "Configurações")
                }
                
                Spacer()
                
                Button {
                    initialLogViewModel.signout()
                } label: {
                    Text("Sair")
                        .bold()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(red: 0.6, green: 0, blue: 0)) // lower values make the color darker
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color(red: 0.6, green: 0, blue: 0), lineWidth: 1) // lower values make the color darker
                        )
                        .font(.custom("Nunito-SemiBold", size: 20))
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
            .sheet(isPresented: $isShowingImagePicker) {
                // Present an image picker to change the image
                Text("Image Picker")
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let profile = ProfileViewModel(
            image: Image("3davatar2"),
            name: "John Doe",
            bloodType: "A+",
            age: 30
        )
        
        ProfileView(profile: profile, name: "guga dias", fakeName: "liz taylor", email: "diasgustaavo@icloud.com", phone: "83981474782", CEP: "58073343", neighborhood: "Cidade dos Colibris", street: "Rua Simas Turbo", number: "69", complement: "22", gender: 1)
    }
}
