//
//  RequestView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 09/06/23.
//

import SwiftUI

struct RequestView: View {
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    @StateObject var viewModel: RequestViewModel = RequestViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image(uiImage: UIImage(named: "3davatar2")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .padding(.leading)
                        
                        Text("Joana Dolores")
                            .lineLimit(1)
                            .font(.custom("Nunito-SemiBold", size: 22))
                            .padding()
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    HStack {
                        Text("Suas principais informações")
                            .font(.custom("Nunito-Light", size: 16))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Solteiro(a) / Nacionalidade: Brasileiro(a) / Sangue: O- Tratamento médico / Cirurgia")
                            .font(.custom("Nunito-Light", size: 16))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Suas Solicitações")
                            .font(.custom("Nunito-SemiBold", size: 22))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding()
                    
                    ForEach(viewModel.requests, id: \.self) { req in
                        NavigationLink(destination: MakeRequestView(requestID: req.id ?? "", viewModel: viewModel).navigationBarBackButtonHidden()) {
                            HStack {
                                Image(uiImage: UIImage(named: "3davatar2")!)
                                    .resizable()
                                    .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenWidth * 0.2)
                                
                                Spacer()
                                
                                Text("Principais informações do agendamento")
                                    .font(.custom("Nunito-Light", size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                Image(systemName: "pencil")
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.accentColor, lineWidth: 0.8)
                            )
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                        .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                    }
                    
                    NavigationLink {
                        MakeRequestView(requestID: "", viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack {
                            Text("Nova soliticação")
                            
                            Image(systemName: "plus.circle")
                        }
                        .font(.custom("Nunito-SemiBold", size: 22))
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                        .padding()
                    }
                    
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            if let currentUserUID = initialLogViewModel.currentUser?.uid {
                viewModel.fetchRequests(for: currentUserUID)
            }
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
