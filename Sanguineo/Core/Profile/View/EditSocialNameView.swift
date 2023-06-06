//
//  EditSocialNameView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 06/06/23.
//

import SwiftUI

struct EditSocialNameView: View {
    
    @Binding var name: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { scrollViewProxy in
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
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                        
                        HStack {
                            Text("Editar nome social")
                                .font(.custom("Nunito-SemiBold", size: 22))
                                .multilineTextAlignment(.leading)
                            
                            Spacer().frame(width: 180)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        ResponsiveSimpleCustomTextField(id: 1, scrollViewProxy: scrollViewProxy, content: $name)
                        
                        Text("Por gentileza, preencha o campo do seu nome social, entendido como o nome pelo qual você deseja ser chamado durante o atendimento no hemocentro.")
                            .font(.custom("Nunito-Light", size: 15))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
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
        }
    }
}

struct EditSocialNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditSocialNameView(name: Binding.constant("guga dias"))
    }
}
