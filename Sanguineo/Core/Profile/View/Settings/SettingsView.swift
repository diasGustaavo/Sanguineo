//
//  SettingsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI

struct SettingsView: View {
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
                    
                    Text("Termos de uso")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                ScrollView {
                    NavigationLink {
                        NotificationsView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        CustomCell(leftSymbol: "bell", buttonText: "Gerenciar notificações")
                    }
                    
                    CustomCell(leftSymbol: "paintpalette", buttonText: "Tema")
                    
                    CustomCell(leftSymbol: "info.circle", buttonText: "Sobre esta versão")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
