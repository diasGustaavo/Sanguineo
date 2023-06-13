//
//  RewardMainComponentView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 13/06/23.
//

import SwiftUI

struct RewardMainComponentView: View {
    let stepsComplete: Int
    let productName: String
    
    init(stepsComplete: Int = 0, productName: String = "rappi") {
        self.stepsComplete = stepsComplete
        self.productName = productName
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: UIImage(named: "\(productName).png")!)
                    .resizable()
                    .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenWidth * 0.2)
                
                VStack {
                    HStack {
                        Text("Gift card R$10")
                            .font(.custom("Nunito-SemiBold", size: 22))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20))
                            .if(stepsComplete >= 4, transform: { view in
                                view.foregroundColor(.accentColor)
                            })
                    }
                    
                    HStack {
                        Text("Desconto em compras \(productName.capitalizingFirstLetter())")
                            .font(.custom("Nunito-Light", size: 16))
                        
                        Spacer()
                    }
                }
                .padding(.leading)
            }
            .padding(.horizontal)
            
            HStack {
                VStack {
                    Image(systemName: "drop")
                        .frame(width: UIScreen.screenWidth * 0.05, height: UIScreen.screenWidth * 0.05)
                        .if(stepsComplete >= 1, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                       
                    RoundedRectangle(cornerRadius: 7.0)
                        .frame(width: 60, height: 3)
                        .if(stepsComplete >= 1, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "drop")
                        .frame(width: UIScreen.screenWidth * 0.05, height: UIScreen.screenWidth * 0.05)
                        .if(stepsComplete >= 2, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                       
                    RoundedRectangle(cornerRadius: 7.0)
                        .frame(width: 60, height: 3)
                        .if(stepsComplete >= 2, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "drop")
                        .frame(width: UIScreen.screenWidth * 0.05, height: UIScreen.screenWidth * 0.05)
                        .if(stepsComplete >= 3, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                       
                    RoundedRectangle(cornerRadius: 7.0)
                        .frame(width: 60, height: 3)
                        .if(stepsComplete >= 3, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "tag")
                        .frame(width: UIScreen.screenWidth * 0.05, height: UIScreen.screenWidth * 0.05)
                        .if(stepsComplete >= 4, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                       
                    RoundedRectangle(cornerRadius: 7.0)
                        .frame(width: 60, height: 3)
                        .if(stepsComplete >= 4, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 22)
        }
        .padding(.vertical)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.accentColor, lineWidth: 0.8)
        )
    }
}

struct RewardMainComponentView_Previews: PreviewProvider {
    static var previews: some View {
        RewardMainComponentView()
            .padding(.horizontal)
    }
}
