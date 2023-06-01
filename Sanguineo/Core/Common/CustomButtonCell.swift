//
//  CustomButtonCell.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 01/06/23.
//

import SwiftUI

struct CustomButtonCell: View {
    let leftSymbol: String
    let buttonText: String
    let rightSymbol = "chevron.right"
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                HStack {
                    Image(systemName: leftSymbol)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 6)
                    
                    Text(buttonText)
                        .font(.custom("Nunito-SemiBold", size: 18))
                    
                    Spacer()
                    
                    Image(systemName: rightSymbol)
                        .fontWeight(.regular)
                        .foregroundColor(.accentColor)
                }
                .padding()
                .foregroundColor(.primary)
                .background(Color.white)
            }
            
            Divider()
                .frame(height: 1)
                .background(Color.gray)
        }
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct CustomButtonCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonCell(leftSymbol: "star.fill", buttonText: "Custom Button"){
            print("button pressed!")
        }
        .padding()
    }
}
