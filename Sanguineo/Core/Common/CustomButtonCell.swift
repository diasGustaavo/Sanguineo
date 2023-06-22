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
                    HStack {
                        Image(systemName: leftSymbol)
                            .imageScale(.large)  // change this to adjust size
                        Spacer()
                    }
                    .frame(width: 30) // Adjust this width based on your needs
                    
                    Text(buttonText)
                        .font(.custom("Nunito-SemiBold", size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: rightSymbol)
                        .imageScale(.large)  // change this to adjust size
                        .foregroundColor(.accentColor)
                }
                .padding()
                .foregroundColor(.primary)
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
