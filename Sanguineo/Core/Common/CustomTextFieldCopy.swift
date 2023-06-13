//
//  CustomTextFieldCopy.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 13/06/23.
//

import SwiftUI
import Introspect
import UIKit

struct CustomTextFieldCopy: View {
    @Binding public var content: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(content: Binding<String>, logo: String = "envelope", placeholder: String = "Placeholder", keyboardType: UIKeyboardType = .default) {
        self._content = content
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            TextField(placeholder, text: $content)
                .padding(.horizontal)
                .autocapitalization(.none)
                .keyboardType(keyboardType)
                
            Spacer()
            
            Button(action: {
                UIPasteboard.general.string = content
            }) {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
