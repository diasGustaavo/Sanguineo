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
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
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
                
                CustomTextField(content: $addressViewModel.typedSearchAddress, logo: "magnifyingglass", placeholder: "Endereço e número", keyboardType: .default)
                    .padding()
                
                if !addressViewModel.isSearching {
                    Button {
                        // some action
                    } label: {
                        VStack {
                            Button {
                                addressViewModel.addCurrentLocation()
                            } label: {
                                HStack {
                                    Image(systemName: "location")
                                        .foregroundColor(.accentColor)
                                    
                                    Text("Usar a localização atual")
                                        .font(.custom("Nunito-Regular", size: 22))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                            }
                            
                            HStack {
                                Text(addressViewModel.currentLocation)
                                    .font(.custom("Nunito-Light", size: 16))
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                    .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                    .matchedGeometryEffect(id: "Button1", in: animation)
                    .transition(.move(edge: .trailing))
                }
                
                ZStack {
                    Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                    
                    if !addressViewModel.isSearching {
                        ScrollView {
                            Spacer().frame(height: 10)
                            
                            ForEach(addressViewModel.addresses, id: \.self) { address in
                                let addressComponents = address.components(separatedBy: ",")
                                AddressBasicComponentView(isChecked: .constant(addressViewModel.selectedAddress == address),
                                                          buttonFunction: {
                                    print("DEBUG: button selected")
                                    withAnimation {
                                        self.addressViewModel.selectedAddress = address
                                    }
                                },
                                                          eraseAddress: {
                                    print("DEBUG: button erased")
                                    self.addressViewModel.eraseAddress(address)
                                }, street: addressComponents.first ?? "Rua desconhecida", area: addressComponents.dropFirst().joined(separator: ",").trimmingCharacters(in: .whitespaces))
                                .padding(.top, 2)
                                .padding(.horizontal)
                            }
                        }
                        .transition(.move(edge: .trailing))
                    } else {
                        ScrollView {
                            ForEach(addressViewModel.searchedLikeAddresses, id: \.self) { searchedLikeAddress in
                                Button {
                                    addressViewModel.addAddress(searchedLikeAddress)
                                    addressViewModel.typedSearchAddress = ""
                                } label: {
                                    AddressSearchedItemView(address: searchedLikeAddress)
                                        .padding(.horizontal)
                                        .padding(.top)
                                }
                                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                            }
                        }
                        .transition(.move(edge: .leading))
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
