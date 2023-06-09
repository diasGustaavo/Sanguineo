//
//  EditEmailView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 06/06/23.
//

import SwiftUI

struct EditEmailView: View {
    
    @Binding var email: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { scrollViewProxy in
                    VStack {
                        HStack {
                            Button {
                                self.mode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.custom("Nunito-Semibold", size: 25))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                                    .padding(.trailing)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                        
                        HStack {
                            Text("Editar e-mail")
                                .font(.custom("Nunito-SemiBold", size: 22))
                                .multilineTextAlignment(.leading)
                            
                            Spacer().frame(width: 180)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        ResponsiveSimpleCustomTextField(id: 1, scrollViewProxy: scrollViewProxy, content: $email, keyboardType: .emailAddress)
                        
                        Text("Por favor, escolha um endereço de e-mail de sua preferência para receber as notificações.")
                            .font(.custom("Nunito-Light", size: 16))
//                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            UserService.shared.updateUser(email: email)
                            self.mode.wrappedValue.dismiss()
                        } label: {
                            Text("Enviar")
                                .font(.custom("Nunito-Regular", size: 22))
                                .frame(height: 56)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color(UIColor(named: "AccentColor")!))
                                .cornerRadius(7)
                                .padding()
                        }
                    }
                }
            }
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.mode.wrappedValue.dismiss()
                }
                
            }))
        }
    }
}

struct EditEmailView_Previews: PreviewProvider {
    static var previews: some View {
        EditEmailView(email: Binding.constant("diasgustaavo@icloud.com"))
    }
}
