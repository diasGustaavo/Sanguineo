//
//  CustomTextField.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 23/05/23.
//

import SwiftUI
import Introspect

struct CustomTextField: View {
    @Binding public var content: String
    let logo: String
    let placeholder: String
    @State private var isSecured = true
    let keyboardType: UIKeyboardType
    
    init(content: Binding<String>, logo: String = "envelope", placeholder: String = "Placeholder", keyboardType: UIKeyboardType = .default) {
        self._content = content
        self.logo = logo
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        HStack {
            Image(systemName: logo)
                .foregroundColor(.accentColor)
                .font(.system(size: 24))
                .frame(width: UIScreen.screenWidth * 0.05)
            
            ZStack(alignment: .leading) {
                if content.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)  // Color of placeholder
                        .font(.custom("Nunito-Light", size: 18)) // Font family and size of placeholder
                        .padding(.horizontal)  // Padding to align with TextField
                }
                if placeholder == "Password" || placeholder == "Senha" {
                    ZStack(alignment: .trailing) {
                        if isSecured {
                            SecureField("", text: $content)
                                .padding(.horizontal)
                                .padding(.trailing, 20)
                                .autocapitalization(.none)
                                .keyboardType(keyboardType)
                        } else {
                            TextField("", text: $content)
                                .padding(.horizontal)
                                .padding(.trailing, 20)
                                .autocapitalization(.none)
                                .keyboardType(keyboardType)
                        }
                        Button(action: {
                            self.isSecured.toggle()
                        }) {
                            Image(systemName: self.isSecured ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.isSecured ? .gray : .blue)
                        }
                    }
                } else {
                    TextField("", text: $content)
                        .padding(.horizontal)  // Same padding as placeholder
                        .autocapitalization(.none)
                        .keyboardType(keyboardType)
                }
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
