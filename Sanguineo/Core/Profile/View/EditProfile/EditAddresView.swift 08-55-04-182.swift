//
//  EditAddresView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 06/06/23.
//

import SwiftUI

struct EditAddressView: View {
    
    @Binding var CEP: String
    @Binding var neighborhood: String
    @Binding var street: String
    @Binding var number: String
    @Binding var complement: String
    
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
                                    .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                                    .padding(.trailing)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                        
                        Group {
                            HStack {
                                Text("Editar endereço")
                                    .font(.custom("Nunito-SemiBold", size: 22))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer().frame(width: 180)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                                .frame(height: 50)
                        }
                        
                        // CEP
                        Group {
                            HStack {
                                Text("CEP")
                                    .font(.custom("Nunito-SemiBold", size: 17))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ResponsiveSimpleCustomTextField(id: 1, scrollViewProxy: scrollViewProxy, content: $CEP, font: "Nunito-Light", keyboardType: .numberPad)
                                .onChange(of: CEP) { newValue in
                                    CEP = format(with: "XXXXX-XXX", phone: newValue)
                                }
                        }
                        
                        // Bairro
                        Group {
                            HStack {
                                Text("Bairro")
                                    .font(.custom("Nunito-SemiBold", size: 17))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ResponsiveSimpleCustomTextField(id: 2, scrollViewProxy: scrollViewProxy, content: $neighborhood, font: "Nunito-Light")
                        }
                        
                        // Bairro
                        Group {
                            HStack {
                                Text("Rua/Avenida")
                                    .font(.custom("Nunito-SemiBold", size: 17))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ResponsiveSimpleCustomTextField(id: 3, scrollViewProxy: scrollViewProxy, content: $street, font: "Nunito-Light")
                        }
                        
                        // Numero
                        Group {
                            HStack {
                                Text("Número")
                                    .font(.custom("Nunito-SemiBold", size: 17))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ResponsiveSimpleCustomTextField(id: 4, scrollViewProxy: scrollViewProxy, content: $number, font: "Nunito-Light", keyboardType: .numberPad)
                        }
                        
                        // Complemento
                        Group {
                            HStack {
                                Text("Complemento")
                                    .font(.custom("Nunito-SemiBold", size: 17))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ResponsiveSimpleCustomTextField(id: 5, scrollViewProxy: scrollViewProxy, content: $complement, font: "Nunito-Light")
                        }
                        
                        Group {
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
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

struct EditAddressView_Previews: PreviewProvider {
    static var previews: some View {
        EditAddressView(CEP: Binding.constant("58073343"), neighborhood: Binding.constant("Cidade dos Colibris"), street: Binding.constant("Rua Simas Turbo"), number: Binding.constant("69"), complement: Binding.constant("22"))
    }
}
