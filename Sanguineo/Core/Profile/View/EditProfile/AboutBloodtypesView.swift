//
//  AboutBloodtypesView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 28/06/23.
//

import SwiftUI

struct AboutBloodtypesView: View {
    @Environment(\.presentationMode) var presentationMode
    
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
                            Text("Sobre os tipos")
                                .font(.custom("Nunito-SemiBold", size: 22))
                                .multilineTextAlignment(.leading)
                            
                            Spacer().frame(width: 180)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Group {
                            HStack {
                                Image("bloodtype")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                                Text("Tipo A")
                                    .font(.custom("Nunito-Bold", size: 19))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("Este tipo de sangue tem antígenos A nas células vermelhas do sangue e anticorpos B no plasma. Isso significa que alguém com tipo sanguíneo A pode doar sangue para pessoas com tipos A e AB, mas pode receber sangue apenas de indivíduos com tipos A ou O.")
                                    .font(.custom("Nunito-Light", size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        
                        Group {
                            HStack {
                                Image("bloodtype")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                                Text("Tipo B")
                                    .font(.custom("Nunito-Bold", size: 19))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("Este tipo tem antígenos B nas células vermelhas do sangue e anticorpos A no plasma. Portanto, as pessoas com tipo B podem doar sangue para indivíduos com tipos B e AB, mas podem receber sangue de indivíduos com tipos B ou O.")
                                    .font(.custom("Nunito-Light", size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        
                        Group {
                            HStack {
                                Image("bloodtype")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                                Text("Tipo AB")
                                    .font(.custom("Nunito-Bold", size: 19))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("As pessoas com este tipo de sangue têm antígenos A e B nas células vermelhas do sangue, mas não têm anticorpos A ou B no plasma. Isso torna o tipo AB o receptor universal, pois as pessoas com este tipo podem receber sangue de qualquer tipo: A, B, AB ou O. No entanto, elas só podem doar para outras pessoas do tipo AB.")
                                    .font(.custom("Nunito-Light", size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        
                        Group {
                            HStack {
                                Image("bloodtype")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                                Text("Tipo O")
                                    .font(.custom("Nunito-Bold", size: 19))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("Este tipo de sangue não tem antígenos A ou B nas células vermelhas do sangue, mas tem ambos os anticorpos A e B no plasma. Isso faz do tipo O o doador universal, pois pessoas com tipo O podem doar sangue para qualquer tipo: A, B, AB ou O. No entanto, elas só podem receber de outros do tipo O.")
                                    .font(.custom("Nunito-Light", size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct AboutBloodtypesView_Previews: PreviewProvider {
    static var previews: some View {
        AboutBloodtypesView()
    }
}
