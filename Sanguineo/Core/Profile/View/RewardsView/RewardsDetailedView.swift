//
//  RewardsDetailedView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 13/06/23.
//

import SwiftUI

struct RewardsDetailedView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var code: String = "XXXX-XXXX-XXXX-XXXX"
    
    var body: some View {
        NavigationView {
            ScrollView {
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
                        
                        Text("Código")
                            .font(.custom("Nunito-Bold", size: 20))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Spacer().frame(width: 40)
                    }
                    .padding()
                    .padding(.horizontal, 6)
                    
                    Image(systemName: "tag")
                        .font(.system(size: 70))
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        Spacer().frame(width: 50)
                        
                        Text("Aqui está o código para resgatar em seu app solicitado:")
                            .font(.custom("Nunito-Light", size: 16))
                            .multilineTextAlignment(.center)
                        
                        Spacer().frame(width: 50)
                    }
                    
                    CustomTextFieldCopy(content: $code)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    HStack {
                        Spacer()
                        
                        Text("Após solicitar, o código estará válido por 48 horas. Caso não seja resgatado dentro desse prazo, seus créditos serão devolvidos e o gift será desativado.")
                            .font(.custom("Nunito-Light", size: 16))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Spacer().frame(width: 50)
                        
                        Text("Atenção")
                            .font(.custom("Nunito-Light", size: 16))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        
                        Spacer().frame(width: 50)
                    }
                    .padding(.horizontal, 25)
                    
                    HStack {
                        Spacer()
                        
                        Text("ao cadastrar seu código nos devidos aplicativos ou sites você não terá mais acesso a eles aqui, fique atento na validade deles no próprio app ou site.")
                            .font(.custom("Nunito-Light", size: 16))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                    
                    Button {
                        // some action
                    } label: {
                        HStack {
                            Spacer()
                            
                            Text("Ajuda?")
                                .font(.custom("Nunito-Light", size: 16))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, 25)
                }
            }
        }
    }
}

struct RewardsDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsDetailedView()
    }
}
