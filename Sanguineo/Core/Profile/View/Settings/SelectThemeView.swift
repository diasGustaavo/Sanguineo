//
//  SelectThemeView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI

struct Option: Identifiable {
    let id = UUID()
    let symbol: String
    let text: String
}

struct SelectThemeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selectedOption: String?

    var options = [
        Option(symbol: "window.shade.open", text: "Claro"),
        Option(symbol: "window.shade.closed", text: "Escuro"),
        Option(symbol: "globe.americas", text: "Padrão do sistema")
    ]
    
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
                    
                    Text("Gerenciar notificações")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                ScrollView {
                    ForEach(options) { option in
                        Button {
                            withAnimation {
                                selectedOption = option.text
                            }
                        } label: {
                            CustomCheckmarkCell(leftSymbol: option.symbol, checkmarkText: option.text, isChecked: .constant(selectedOption == option.text))
                        }
                    }
                }
            }
        }
    }
}

struct SelectThemeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectThemeView()
    }
}
