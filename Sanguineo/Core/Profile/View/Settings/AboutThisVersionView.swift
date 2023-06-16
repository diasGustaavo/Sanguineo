//
//  AboutThisVersionView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI
import AVFoundation
import CoreLocation

struct AboutThisVersionView: View {
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
    }
}

struct AboutThisVersionView_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisVersionView()
    }
}
