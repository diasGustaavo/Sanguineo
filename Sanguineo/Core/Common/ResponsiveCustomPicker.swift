//
//  ResponsiveCustomPicker.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 07/06/23.
//

import SwiftUI

struct ResponsiveCustomPicker: View {
    @Binding public var selection: Int
    let logo: String
    let options: [String]
    let id: Int
    let description: String

    init(id: Int, selection: Binding<Int>, logo: String = "list.dash", options: [String], description: String = "") {
        self.id = id
        self._selection = selection
        self.logo = logo
        self.options = options
        self.description = description
    }
    
    var body: some View {
        HStack {
            Image(systemName: logo)
                .foregroundColor(.accentColor)
                .font(.system(size: 24))
                .frame(width: UIScreen.screenWidth * 0.05)
            
            if description.count > 0 {
                Text(description)
                    .foregroundColor(.gray)  // Color of placeholder
                    .font(.custom("Nunito-Light", size: 18)) // Font family and size of placeholder
                    .padding(.horizontal)  // Padding to align with TextField
            }
            
            Spacer()
            
            ZStack(alignment: .leading) {
                Picker(selection: $selection, label: Text("")) {
                    ForEach(options.indices, id: \.self) { index in
                        Text(self.options[index]).tag(index)
                    }
                }
                .id(id)
            }
            .padding(.leading, 0)  // remove padding from left
        }
        .padding(.leading)
        .padding(.vertical, 4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
        )
        .id(id)
    }
}
