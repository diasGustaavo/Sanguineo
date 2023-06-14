//
//  AddressView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 14/06/23.
//

import SwiftUI

struct AddressView: View {
    @Namespace private var animation
    
    @EnvironmentObject var addressViewModel: AddressViewModel
    
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
                    
                    Text("Endereço cadastrado")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                CustomTextField(content: $addressViewModel.selectedAddress, logo: "magnifyingglass", placeholder: "Endereço e número", keyboardType: .default)
                    .padding()
                
                if !addressViewModel.isSearching {
                    Button {
                        // some action
                    } label: {
                        VStack {
                            HStack {
                                Image(systemName: "location")
                                    .foregroundColor(.accentColor)
                                
                                Text("Usar a localização atual")
                                    .font(.custom("Nunito-Regular", size: 22))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("Manaíra, João Pessoa - PB")
                                    .font(.custom("Nunito-Light", size: 16))
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "Button1", in: animation)
                    .transition(.move(edge: .trailing))
                }
                
                ZStack {
                    Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                    
                    if !addressViewModel.isSearching {
                        ScrollView {
                            AddressBasicComponentView(isChecked: .constant(true), buttonFunction: {
                                print("Button pressed!")
                            }, eraseAddress: {
                                print("Address erased!")
                            })
                            .padding(.horizontal)
                            .padding(.bottom, 2)
                            .padding(.top)
                            
                            AddressBasicComponentView(isChecked: .constant(false), buttonFunction: {
                                print("Button pressed!")
                            }, eraseAddress: {
                                print("Address erased!")
                            })
                            .padding(.horizontal)
                            .padding(.bottom, 2)
                            
                            AddressBasicComponentView(isChecked: .constant(false), buttonFunction: {
                                print("Button pressed!")
                            }, eraseAddress: {
                                print("Address erased!")
                            })
                            .padding(.horizontal)
                            .padding(.bottom, 2)
                        }
                        .transition(.move(edge: .trailing))
                    }
                }
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
            .environmentObject(AddressViewModel())
    }
}
