//
//  AboutThisVersionView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI

struct AboutThisVersionView: View {
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
                    
                    Text("Sobre esta versão")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                ScrollView {
                    NavigationLink {
                        PrivacyPolicyView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        CustomCell(leftSymbol: "lock", buttonText: "Politica de privacidade")
                    }
                    
                    CustomCell(leftSymbol: "checkmark", buttonText: "Versão 1.00.01 (69962472700)", showRightButton: false)
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

struct AboutThisVersionView_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisVersionView()
    }
}
