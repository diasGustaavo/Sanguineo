//
//  ProfileView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var isShowingImagePicker = false
    
    @EnvironmentObject var profile: ProfileViewModel

    @EnvironmentObject var initialLogViewModel: InitialLogViewModel

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if !profile.isLoading {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                ZStack(alignment: .topTrailing) {
                                    Image(uiImage: profile.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                    
                                    Image(systemName: "pencil.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .padding(4)
                                        .foregroundColor(.white)
                                        .background(Color.black.opacity(0.5))
                                        .clipShape(Circle())
                                        .padding(4)
                                        .offset(x: 8, y: 50)
                                        .opacity(isShowingImagePicker ? 0 : 1)
                                }
                                .padding(.trailing)
                            }
                    } else {
                        Spinner(lineWidth: 5, height: 32, width: 32)
                            .frame(width: 80, height: 80)
                    }

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

                            Text(profile.bloodtype)
                                .font(.custom("Nunito-Regular", size: 15))
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal)

                NavigationLink {
                    EditProfileInfoView()
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
        .onChange(of: selectedItem) { newItem in
            Task {
                // Retrive selected asset in the form of Data
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        if let currentUserUID = initialLogViewModel.currentUserUID {
                            profile.image = uiImage
                            profile.updateImage(userID: currentUserUID)
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
    }
}
