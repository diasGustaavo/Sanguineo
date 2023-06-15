//
//  EditNameView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 06/06/23.
//

import SwiftUI

struct EditNameView: View {
    
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
                            Text("Editar nome de preferência")
                                .font(.custom("Nunito-SemiBold", size: 22))
                                .multilineTextAlignment(.leading)
                            
                            Spacer().frame(width: 100)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        ResponsiveSimpleCustomTextField(id: 1, scrollViewProxy: scrollViewProxy, content: $name)
                        
                        Text("Por favor, escreva o seu nome completo exatamente como consta em seu documento enviado para a triagem, juntamente com o seu número de CPF, RG e CNH. É importante que todas as informações estejam corretas e atualizadas para que possamos realizar a análise correta.")
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

struct EditNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditNameView(name: Binding.constant("guga dias"))
    }
}
