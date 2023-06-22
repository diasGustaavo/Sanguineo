//
//  CustomCheckmarkCell.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 16/06/23.
//

import SwiftUI

struct CustomCheckmarkCell: View {
    let leftSymbol: String
    let checkmarkText: String
    let isChecked: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: leftSymbol)
                    .imageScale(.large)
                
                Text(checkmarkText)
                    .font(.custom("Nunito-SemiBold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: action) {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .imageScale(.large)
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

struct CustomCheckmarkCell_Previews: PreviewProvider {
    @State static var checkmarkStatus = false

    static var previews: some View {
        CustomCheckmarkCell(leftSymbol: "star.fill", checkmarkText: "Custom Checkmark", isChecked: checkmarkStatus) {
            checkmarkStatus.toggle()
        }
        .padding()
    }
}
