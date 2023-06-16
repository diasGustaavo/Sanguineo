//
//  PrivacyPolicyView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI
import AVFoundation
import CoreLocation

struct PrivacyPolicyView: View {
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
                    
                    Text("Politica de privacidade")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        SectionView(title: "1. Introdução", content: "Bem-vindo à Política de Privacidade do nosso aplicativo. Respeitamos a sua privacidade e estamos comprometidos em proteger os seus dados pessoais. Esta Política de Privacidade irá informá-lo sobre como cuidamos dos seus dados pessoais quando você usa o nosso aplicativo e informá-lo sobre os seus direitos de privacidade e como a lei protege você.")
                                            
                        SectionView(title: "2. Dados que coletamos", content: "Podemos coletar, usar, armazenar e transferir diferentes tipos de dados pessoais sobre você que coletamos, incluindo, mas não se limitando a: Dados de Identificação: nome, data de nascimento, gênero. Dados de Contato: endereço de e-mail, número de telefone. Dados Técnicos: endereço IP, tipo e versão do navegador, configuração de fuso horário, tipos e versões de plug-in do navegador, sistema operacional e plataforma, e outros dados de tecnologia nos dispositivos que você usa para acessar este aplicativo.")
                                            
                        SectionView(title: "3. Como usamos seus dados", content: "Usamos seus dados pessoais para os seguintes fins: Para registrar e gerenciar a sua conta no aplicativo. Para enviar atualizações importantes, como alterações em nossas políticas e termos de uso. Para responder às suas perguntas e solicitações. Para melhorar o nosso aplicativo através da análise de como você o usa.")
                                            
                        SectionView(title: "4. Divulgação de seus dados", content: "Não compartilhamos suas informações pessoais com terceiros, exceto quando necessário para fornecer o serviço (por exemplo, servidores de hospedagem) ou quando obrigado por lei.")
                                            
                        SectionView(title: "5. Segurança", content: "Estamos comprometidos em garantir a segurança dos seus dados. Implementamos medidas de segurança adequadas para prevenir que seus dados pessoais sejam acidentalmente perdidos, usados ou acessados de maneira não autorizada, alterados ou divulgados.")
                                            
                        SectionView(title: "6. Seus direitos", content: "De acordo com as leis de proteção de dados, você tem direitos em relação aos seus dados pessoais. Você tem o direito de solicitar acesso, correção, exclusão, restrição, transferência, de retirar o seu consentimento para o processamento de seus dados pessoais a qualquer momento, e de fazer uma reclamação a uma autoridade de proteção de dados.")
                                            
                        SectionView(title: "7. Alterações à Política de Privacidade", content: "Podemos atualizar nossa Política de Privacidade de tempos em tempos. Iremos notificá-lo de qualquer alteração postando a nova Política de Privacidade nesta página.")
                                            
                        SectionView(title: "8. Contato", content: "Se você tiver alguma dúvida sobre esta Política de Privacidade, por favor, entre em contato conosco através do 08.heir-tilt@icloud.com. Por favor, leia esta política cuidadosamente para entender nossas políticas e práticas em relação aos seus dados pessoais e como os trataremos. Ao usar nosso aplicativo, você concorda com esta Política de Privacidade.")

                        
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                }
            }
        }
    }
}

struct SectionView: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.custom("Nunito-Bold", size: 18))
            Text(content)
                .font(.custom("Nunito-Regular", size: 16))
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
