//
//  ResponsiveSimpleCustomTextField.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 06/06/23.
//

import SwiftUI
import Introspect

struct ResponsiveSimpleCustomTextField: View {
    @Binding public var content: String
    let id: Int
    let scrollViewProxy: ScrollViewProxy
    let font: String
    let keyboardType: UIKeyboardType
    
    init(id: Int, scrollViewProxy: ScrollViewProxy, content: Binding<String>, font: String = "Nunito-SemiBold", keyboardType: UIKeyboardType = .default) {
        self.id = id
        self.scrollViewProxy = scrollViewProxy
        self._content = content
        self.font = font
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            TextField("", text: $content)
                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                .font(.custom(font, size: 20))
                .keyboardType(keyboardType)  // Set the keyboard type
                .introspectTextField { textField in
                    self.scrollOnAppear(textField: textField)
                }
                .padding(.bottom, 8)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
        }
        .padding(.horizontal)
        .padding(.bottom)
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
