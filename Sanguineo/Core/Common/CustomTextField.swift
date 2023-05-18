//
//  CustomTextField.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 18/05/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding public var content: String
    let logo: String
    let placeholder: String
    @State private var isSecured = true
    
    init(content: Binding<String>, logo: String = "envelope", placeholder: String = "Placeholder") {
        self._content = content
        self.logo = logo
        self.placeholder = placeholder
    }
    
    var body: some View {
        HStack {
            Image(systemName: logo) // SF Symbol for the kigi
                .foregroundColor(.accentColor)
                .font(.system(size: 24))
                .frame(width: UIScreen.screenWidth * 0.05)
            
            //            TextField(placeholder, text: $content)
            //                .padding(.leading)
            //                .autocapitalization(.none)
            //                .keyboardType(.emailAddress)
            
            ZStack(alignment: .leading) {
                if content.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)  // Color of placeholder
                        .font(.custom("Nunito-Light", size: 18)) // Font family and size of placeholder
                        .padding(.horizontal)  // Padding to align with TextField
                }
                if placeholder == "Password" {
                    ZStack(alignment: .trailing) {
                        if isSecured {
                            SecureField("", text: $content)
                                .padding(.horizontal)
                                .padding(.trailing, 20)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                        } else {
                            TextField("", text: $content)
                                .padding(.horizontal)
                                .padding(.trailing, 20)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
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
                        .keyboardType(.emailAddress)
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(content: .constant(""), placeholder: "Password")
            .padding()
    }
}
