//
//  ResponsiveCustomTextField.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 18/05/23.
//

import SwiftUI
import Introspect

struct ResponsiveCustomTextField: View {
    @Binding public var content: String
    let logo: String
    let placeholder: String
    let id: Int
    let scrollViewProxy: ScrollViewProxy
    @State private var isSecured = true
    
    init(id: Int, scrollViewProxy: ScrollViewProxy, content: Binding<String>, logo: String = "envelope", placeholder: String = "Placeholder") {
        self.id = id
        self.scrollViewProxy = scrollViewProxy
        self._content = content
        self.logo = logo
        self.placeholder = placeholder
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
                                .keyboardType(.emailAddress)
                                .introspectTextField { textField in
                                    self.scrollOnAppear(textField: textField)
                                }
                        } else {
                            TextField("", text: $content)
                                .padding(.horizontal)
                                .padding(.trailing, 20)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .introspectTextField { textField in
                                    self.scrollOnAppear(textField: textField)
                                }
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
                        .introspectTextField { textField in
                            self.scrollOnAppear(textField: textField)
                        }
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
        )
        .id(id)
    }

    private func scrollOnAppear(textField: UITextField) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            let textFieldFrame = textField.convert(textField.bounds, to: nil)
            let diff = UIScreen.main.bounds.height - textFieldFrame.maxY
            if diff < 0 {
                withAnimation {
                    scrollViewProxy.scrollTo(id, anchor: .bottom)
                }
            }
        }
    }
}
