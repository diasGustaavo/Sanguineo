//
//  SettingsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @GestureState private var dragOffset = CGSize.zero
    
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
                        CustomCell(leftSymbol: "bell", buttonText: "Gerenciar tema")
                    }
                    
                    NavigationLink {
                        SelectThemeView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        CustomCell(leftSymbol: "paintpalette", buttonText: "Tema")
                    }
                    
                    NavigationLink {
                        AboutThisVersionView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        CustomCell(leftSymbol: "info.circle", buttonText: "Sobre esta versão")
                    }
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
