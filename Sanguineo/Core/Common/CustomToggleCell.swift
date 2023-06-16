//
//  CustomToggleCell.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI

struct CustomToggleCell: View {
    let leftSymbol: String
    let toggleText: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: leftSymbol)
                    .imageScale(.large)  // change this to adjust size
                
                Text(toggleText)
                    .font(.custom("Nunito-SemiBold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Toggle("", isOn: $isOn)
                    .labelsHidden() // Hides the empty label
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
            .padding()
            .foregroundColor(.primary)
            .background(Color.white)
            
            Divider()
                .frame(height: 1)
                .background(Color.gray)
        }
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct CustomToggleCell_Previews: PreviewProvider {
    @State static var toggleStatus = false

    static var previews: some View {
        CustomToggleCell(leftSymbol: "star.fill", toggleText: "Custom Toggle", isOn: $toggleStatus)
            .padding()
    }
}
