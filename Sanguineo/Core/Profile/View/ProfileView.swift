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
                            
                            Text(profile.bloodType)
                                .font(.custom("Nunito-Regular", size: 17))
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                NavigationLink {
                    EditProfileInfoView(name: $name, fakeName: $fakeName)
                        .navigationBarBackButtonHidden()
                } label: {
                    CustomCell(leftSymbol: "person", buttonText: "Editar informações do perfil")
                }
                
                CustomButtonCell(leftSymbol: "star", buttonText: "Recompensas") {
                    // some action
                }
                
                CustomButtonCell(leftSymbol: "location", buttonText: "Configurar localização") {
                    // some action
                }
                
                CustomButtonCell(leftSymbol: "checkmark.circle", buttonText: "Permissões do app") {
                    // some action
                }
                
                CustomButtonCell(leftSymbol: "doc.plaintext", buttonText: "Termos de uso") {
                    // some action
                }
                
                CustomButtonCell(leftSymbol: "gearshape", buttonText: "Configurações") {
                    // some action
                }
                
                Spacer()
                
                Button {
                    // some action
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
        
        ProfileView(profile: profile, name: "guga", fakeName: "liz taylor")
    }
}
