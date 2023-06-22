//
//  EditPhoneView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 06/06/23.
//

import SwiftUI

struct EditPhoneView: View {
    
    @Binding var phone: String
    @State var lastPhone = ""
    
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
                        
                        HStack {
                            Text("Editar telefone")
                                .font(.custom("Nunito-SemiBold", size: 22))
                                .multilineTextAlignment(.leading)
                            
                            Spacer().frame(width: 180)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        ResponsiveSimpleCustomTextField(id: 1, scrollViewProxy: scrollViewProxy, content: $phone, keyboardType: .phonePad)
                            .onChange(of: phone) { newValue in
                                phone = format(with: "(XX) XXXXX-XXXX", phone: newValue)
                            }
                        
                        Text("Por favor, forneça um número de telefone de sua preferência para que possamos contatá-lo e/ou enviar informações importantes do hemocentro, se necessário.")
                            .font(.custom("Nunito-Light", size: 16))
//                            .multilineTextAlignment(.leading)
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

struct EditPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhoneView(phone: Binding.constant("83981474782"))
    }
}
