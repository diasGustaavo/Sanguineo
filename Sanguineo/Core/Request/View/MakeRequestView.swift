//
//  MakeRequestView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 26/06/23.
//

import SwiftUI

struct MakeRequestView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var cirurgia = false
    @State var acidente = false
    @State var doenca = false
    @State var tratamento = false
    @State var outro = false
    @State var aditionalInfo = ""
    @State var hemocentro = ""
    
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
                    
                    Text("R. quarto dos quintal, 2055 ")
                        .font(
                            Font.custom("Nunito", size: 17)
                                .weight(.light)
                        )
                        .kerning(0.15)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.24, green: 0.22, blue: 0.22))
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                ScrollView {
                    HStack(alignment: .center, spacing: 12) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 64, height: 64)
                            .background(
                                Image(uiImage: UIImage(named: "3d_avatar_28")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 64, height: 64)
                                    .clipped()
                            )
                        
                        Text("Confirme seus dados")
                            .font(.custom("Nunito-SemiBold", size: 20))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(0)
                    
                    HStack {
                        Text("Nome: João da Silva / CPF: xxx.xxx.xxx-xx / Solteiro(a) Nacionalidade: Brasileiro(a) / Sangue: O- ")
                            .font(
                                Font.custom("Nunito", size: 13)
                                    .weight(.light)
                            )
                            .kerning(0.15)
                            .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
                            .frame(alignment: .topLeading)
                        
                        Spacer()
                    }
                    .padding(.bottom, 6)
                    
                    HStack {
                        Text("Motivos da solicitação")
                            .font(.custom("Nunito-SemiBold", size: 20))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    HStack(spacing: 14) {
                        Button {
                            withAnimation {
                                cirurgia.toggle()
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 8) {
                                Text("Cirurgia")
                                    .font(.custom("Nunito", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(cirurgia ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 0)
                            .frame(height: 40, alignment: .center)
                            .background(cirurgia ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                        }
                        
                        Button {
                            withAnimation {
                                acidente.toggle()
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 8) {
                                Text("Acidente")
                                    .font(.custom("Nunito", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(acidente ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 0)
                            .frame(height: 40, alignment: .center)
                            .background(acidente ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                        }
                        
                        Button {
                            withAnimation {
                                doenca.toggle()
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 8) {
                                Text("Doença")
                                    .font(.custom("Nunito", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(doenca ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 0)
                            .frame(height: 40, alignment: .center)
                            .background(doenca ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                        }

                        Spacer()
                    }
                    
                    HStack(spacing: 14) {
                        Button {
                            withAnimation {
                                tratamento.toggle()
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 8) {
                                Text("Tratamento Médico")
                                    .font(.custom("Nunito", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(tratamento ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 0)
                            .frame(height: 40, alignment: .center)
                            .background(tratamento ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                        }
                        
                        Button {
                            withAnimation {
                                outro.toggle()
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 8) {
                                Text("Outro")
                                    .font(.custom("Nunito", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(outro ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 0)
                            .frame(height: 40, alignment: .center)
                            .background(outro ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                        }

                        Spacer()
                    }
                    .padding(.top, 4)
                    
                    HStack {
                        Text("Informações Adicionais")
                            .font(.custom("Nunito-SemiBold", size: 20))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    
                    HStack(alignment: .top, spacing: 10) {
                        TextEditor(text: $aditionalInfo)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180, alignment: .top)
                    
                    HStack {
                        Text("Hemocentros")
                            .font(.custom("Nunito-SemiBold", size: 20))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    
                    CustomTextField(content: $hemocentro, logo: "magnifyingglass", placeholder: "Nome do hemocentro")
                    
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            
                            Text("Soliticar doação")
                            
                            Spacer()
                        }
                        .font(.custom("Nunito-SemiBold", size: 22))
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

struct MakeRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MakeRequestView()
    }
}
