//
//  TermsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI

struct TermsView: View {
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
                    Text("**1. Coleta de Dados:** Ao utilizar nosso aplicativo, o usuário concorda que podemos coletar e armazenar informações sobre o uso do aplicativo, incluindo dados de navegação, análises e estatísticas.")
                        .font(.custom("Nunito-Light", size: 17))
                        .padding()
                    
                    Text("**2. Informações Pessoais:** Ao utilizar nosso aplicativo, o usuário concorda que podemos acessar e coletar informações pessoais, como nome, endereço de e-mail, número de telefone, entre outros, para fins de autenticação e melhoria da experiência do usuário.")
                        .font(.custom("Nunito-Light", size: 17))
                        .padding()
                    
                    Text("**3. Câmera:** Ao utilizar nosso aplicativo, o usuário concorda que podemos acessar a câmera do dispositivo para permitir o uso de funcionalidades que exigem captura de imagem ou vídeo.")
                        .font(.custom("Nunito-Light", size: 17))
                        .padding()
                    
                    Text("**4. Localização:** Ao utilizar nosso aplicativo, o usuário concorda que podemos acessar as informações de localização do dispositivo para permitir o uso de funcionalidades que exigem geolocalização, como mapas e serviços de entrega.")
                        .font(.custom("Nunito-Light", size: 17))
                        .padding()
                    
                    Text("**5. Compartilhamento de Dados:** Ao utilizar nosso aplicativo, o usuário concorda que podemos compartilhar as informações coletadas com parceiros e prestadores de serviços terceirizados, desde que sejam estritamente necessárias para fornecer nossos serviços e cumprir as obrigações legais.")
                        .font(.custom("Nunito-Light", size: 17))
                        .padding()
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

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
