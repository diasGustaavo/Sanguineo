//
//  EditGenderView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 28/06/23.
//

import SwiftUI

struct EditGenderView: View {
    
    @Binding var selectedGender: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    let genderOptions = ["Masculino", "Feminino", "Outros"]
    
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
                            Text("Editar gênero")
                                .font(.custom("Nunito-SemiBold", size: 22))
                                .multilineTextAlignment(.leading)
                            
                            Spacer().frame(width: 180)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 100)
                        
                        ResponsiveCustomPicker(id: 69, selection: $selectedGender, options: genderOptions, description: "Gênero")
                            .padding(.horizontal, 25)
                            .padding(.vertical)
                        
                        Text("Lembrando que, embora o seu gênero possa ser alterado a qualquer momento, por questões de amostragem precisamos que selecione seu sexo biológico corretamente.")
                            .font(.custom("Nunito-Light", size: 16))
                            .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            UserService.shared.updateUser(gender: genderOptions[selectedGender])
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

struct EditGenderView_Previews: PreviewProvider {
    static var previews: some View {
        EditGenderView(selectedGender: .constant(1))
    }
}
