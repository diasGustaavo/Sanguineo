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

    let street: String  // New property for street name
    let area: String  // New property for area name

    @State private var isVisible: Bool = true

    var body: some View {
        VStack {
            if isVisible {
                HStack {
                    Button {
                        self.buttonFunction()
                    } label: {
                        VStack {
                            HStack {
                                Text(street)  // Use the street property
                                    .font(.custom("Nunito-Regular", size: 22))
                                    .padding(.trailing, 2)
                                    .lineLimit(1)
                                
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
                                Text(area)  // Use the area property
                                    .font(.custom("Nunito-Light", size: 16))
                                    .lineLimit(2)
                                
                                Spacer()
                                
                                Spacer().frame(width: 50)
                            }
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
                            .frame(height: 20)
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
                .transition(.opacity)
            }
        }
        .onAppear {
            isVisible = true
        }
        .onDisappear {
            isVisible = false
        }
    }
}

struct AddressBasicComponentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddressBasicComponentView(isChecked: .constant(true), buttonFunction: {
                print("Button pressed!")
            }, eraseAddress: {
                print("Address erased!")
            }, street: "Rua Empresario Manoel de Brito, n 123", area: "Manaíra, João Pessoa - PB")
            .previewDisplayName("Checked")

            AddressBasicComponentView(isChecked: .constant(false), buttonFunction: {
                print("Button pressed!")
            }, eraseAddress: {
                print("Address erased!")
            }, street: "Rua das Flores, n 123", area: "Manaíra, João Pessoa - PB")
            .previewDisplayName("Unchecked")
        }
        .previewLayout(.sizeThatFits)
    }
}
