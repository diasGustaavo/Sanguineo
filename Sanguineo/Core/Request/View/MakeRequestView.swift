//
//  MakeRequestView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 26/06/23.
//

import SwiftUI

struct MakeRequestView: View {
    let requestID: String
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    @EnvironmentObject var profile: ProfileViewModel
    
    @ObservedObject var viewModel: RequestViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        print("DEBUG: CLOSING1")
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
                        .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                if !viewModel.isPublicationLoading {
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
                            Text("Nome: \(profile.name) / Sangue: \(profile.bloodtype) / Gênero: \(profile.genderName) / Número: \(profile.phone)")
                                .font(
                                    Font.custom("Nunito", size: 13)
                                        .weight(.light)
                                )
                                .kerning(0.15)
                                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
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
                                    viewModel.cirurgia.toggle()
                                }
                            } label: {
                                HStack(alignment: .center, spacing: 8) {
                                    Text("Cirurgia")
                                        .font(.custom("Nunito", size: 16))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(viewModel.cirurgia ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 0)
                                .frame(height: 40, alignment: .center)
                                .background(viewModel.cirurgia ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.accentColor, lineWidth: 1)
                                )
                            }
                            
                            Button {
                                withAnimation {
                                    viewModel.acidente.toggle()
                                }
                            } label: {
                                HStack(alignment: .center, spacing: 8) {
                                    Text("Acidente")
                                        .font(.custom("Nunito", size: 16))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(viewModel.acidente ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 0)
                                .frame(height: 40, alignment: .center)
                                .background(viewModel.acidente ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.accentColor, lineWidth: 1)
                                )
                            }
                            
                            Button {
                                withAnimation {
                                    viewModel.doenca.toggle()
                                }
                            } label: {
                                HStack(alignment: .center, spacing: 8) {
                                    Text("Doença")
                                        .font(.custom("Nunito", size: 16))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(viewModel.doenca ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 0)
                                .frame(height: 40, alignment: .center)
                                .background(viewModel.doenca ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
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
                                    viewModel.tratamento.toggle()
                                }
                            } label: {
                                HStack(alignment: .center, spacing: 8) {
                                    Text("Tratamento Médico")
                                        .font(.custom("Nunito", size: 16))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(viewModel.tratamento ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 0)
                                .frame(height: 40, alignment: .center)
                                .background(viewModel.tratamento ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.accentColor, lineWidth: 1)
                                )
                            }
                            
                            Button {
                                withAnimation {
                                    viewModel.outro.toggle()
                                }
                            } label: {
                                HStack(alignment: .center, spacing: 8) {
                                    Text("Outro")
                                        .font(.custom("Nunito", size: 16))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(viewModel.outro ? Color(UIColor(named: "backColor")!) : Color(UIColor(named: "AccentColor")!))
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 0)
                                .frame(height: 40, alignment: .center)
                                .background(viewModel.outro ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
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
                            TextEditor(text: $viewModel.additionalInfo)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                        .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 5)
                        .frame(maxWidth: .infinity, minHeight: 140, maxHeight: 140, alignment: .top)
                        
                        HStack {
                            Text("Hemocentros")
                                .font(.custom("Nunito-SemiBold", size: 20))
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 8)
                        
                        CustomTextField(content: $viewModel.hemocentro, logo: "stethoscope", placeholder: "Nome do hemocentro")
                        
                        Button {
                            if let currentUserUID = initialLogViewModel.currentUser?.uid {
                                print("DEBUG: CLOSING2")
                                viewModel.saveRequest(authorUID: currentUserUID, reqUID: requestID)
                                viewModel.fetchRequests(for: currentUserUID)
                                self.presentationMode.wrappedValue.dismiss()
                            }
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
                else {
                    VStack {
                        Spacer()
                            .frame(height: 40)
                        
                        Spinner(lineWidth: 5, height: 32, width: 32)
                        
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            if !requestID.isEmpty {
                viewModel.fetchRequestPublication(withId: requestID)
            }
        }
    }
}

struct MakeRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MakeRequestView(requestID: "", viewModel: RequestViewModel())
    }
}
