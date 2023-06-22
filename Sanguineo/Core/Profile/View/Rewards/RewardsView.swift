//
//  RewardsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 13/06/23.
//

import SwiftUI

struct RewardsView: View {
    let stepsComplete: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    init(stepsComplete: Int = 2) {
        self.stepsComplete = stepsComplete
    }
    
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
                                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                                .padding(.trailing)
                        }
                        
                        Spacer()
                        
                        Text("Recompensas")
                            .font(.custom("Nunito-Bold", size: 20))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Spacer().frame(width: 40)
                    }
                    .padding()
                    .padding(.horizontal, 6)
                    
                    Text("Neste lugar, você pode receber vários tipos de recompensa, como descontos, gift cards e ingressos para eventos.")
                        .font(.custom("Nunito-Light", size: 15))
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<4) { i in
                                VStack {
                                    Text("\(i + 1)a")
                                    Text("doação")
                                }
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(i + 1 <= stepsComplete ? Color.accentColor : Color.gray, lineWidth: 0.8)
                                )
                                .overlay(
                                    Image(systemName: i == 3 ? "tag" : "drop")
                                        .font(.system(size: 12))
                                        .foregroundColor(i + 1 <= stepsComplete ? Color.accentColor : Color.gray)
                                        .padding(5),
                                    alignment: .topTrailing
                                )
                                .foregroundColor(i + 1 <= stepsComplete ? Color.accentColor : Color.gray)
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                    }
                    .padding(.leading, 16)
                    
                    HStack {
                        Text("Alimentação")
                            .font(.custom("Nunito-SemiBold", size: 22))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal, 6)
                    
                    NavigationLink {
                        RewardsDetailedView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        RewardMainComponentView(stepsComplete: stepsComplete, productName: "rappi")
                            .padding(.horizontal, 24)
                            .padding(.bottom, 6)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                    }
                    
                    NavigationLink {
                        RewardsDetailedView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        RewardMainComponentView(stepsComplete: stepsComplete, productName: "ifood")
                            .padding(.horizontal, 24)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                    }
                    
                    HStack {
                        Text("Moda")
                            .font(.custom("Nunito-SemiBold", size: 22))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal, 6)
                    
                    NavigationLink {
                        RewardsDetailedView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        RewardMainComponentView(stepsComplete: stepsComplete, productName: "renner")
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                            .padding(.horizontal, 24)
                            .padding(.bottom, 6)
                    }
                }
            }
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}
