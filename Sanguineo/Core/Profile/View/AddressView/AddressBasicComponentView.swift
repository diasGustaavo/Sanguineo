//
//  AddressBasicComponentView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 14/06/23.
//

import SwiftUI

struct AddressBasicComponentView: View {
    @Binding var isChecked: Bool
    let buttonFunction: () -> Void
    let eraseAddress: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button {
                    self.buttonFunction()
                } label: {
                    VStack {
                        HStack {
                            Text("Rua das Flores, n 123")
                                .font(.custom("Nunito-Regular", size: 22))
                                .padding(.trailing, 2)
                            
                            if isChecked {
                                Image(systemName: "checkmark.circle")
                                    .font(.custom("Nunito-SemiBold", size: 20))
                                    .foregroundColor(.accentColor)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 6)
                        
                        Spacer().frame(height: 5)
                        
                        HStack {
                            Text("Manaíra, João Pessoa - PB")
                                .font(.custom("Nunito-Light", size: 16))
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height: 2)
                        
                        HStack {
                            Text("Apto 605 - Mag")
                                .font(.custom("Nunito-Light", size: 16))
                            
                            Spacer()
                        }
                        .padding(.bottom, 6)
                    }
                    .foregroundColor(.black)
                }
                
                VStack {
                    Menu {
                        Button("Apagar", action: eraseAddress)
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.custom("Nunito-SemiBold", size: 20))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .if(isChecked, transform: { view in
                view.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 0.8)
                )
            })
        }
    }
}

struct AddressBasicComponentView_Previews: PreviewProvider {
    static var previews: some View {
        AddressBasicComponentView(isChecked: .constant(true), buttonFunction: {
            print("Button pressed!")
        }, eraseAddress: {
            print("Address erased!")
        })
    }
}
