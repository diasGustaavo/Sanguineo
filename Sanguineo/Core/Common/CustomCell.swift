//
//  CustomCell.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/06/23.
//

import SwiftUI

struct CustomCell: View {
    let leftSymbol: String
    let buttonText: String
    let rightSymbol = "chevron.right"
    var showRightButton: Bool = true
    
    var body: some View {
        VStack {
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
                
                if showRightButton {
                    Image(systemName: rightSymbol)
                        .imageScale(.large)  // change this to adjust size
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
            .foregroundColor(.primary)
            
            Divider()
                .frame(height: 1)
                .background(Color.gray)
        }
        .edgesIgnoringSafeArea(.horizontal)
    }
}


struct CustomCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomCell(leftSymbol: "star.fill", buttonText: "Custom Button")
            .padding()
    }
}
