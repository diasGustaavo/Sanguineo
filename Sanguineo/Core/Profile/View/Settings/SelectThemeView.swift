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
    @GestureState private var dragOffset = CGSize.zero
    
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Nunito-Semibold", size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
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
                    CustomCheckmarkCell(
                        leftSymbol: "window.shade.open",
                        checkmarkText: "Claro",
                        isChecked: viewModel.theme == "white",
                        action: { viewModel.theme = "white" }
                    )
                    
                    CustomCheckmarkCell(
                        leftSymbol: "window.shade.closed",
                        checkmarkText: "Escuro",
                        isChecked: viewModel.theme == "dark",
                        action: { viewModel.theme = "dark" }
                    )
                    
                    CustomCheckmarkCell(
                        leftSymbol: "globe.americas",
                        checkmarkText: "Padrão do sistema",
                        isChecked: viewModel.theme == "system",
                        action: { viewModel.theme = "system" }
                    )
                }
            }
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }))
    }
}

struct SelectThemeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectThemeView().environmentObject(SettingsViewModel())
    }
}
