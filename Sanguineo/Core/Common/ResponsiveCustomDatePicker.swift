//
//  ResponsiveCustomDatePicker.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 06/07/23.
//

import SwiftUI

struct ResponsiveCustomDatePicker: View {
    @Binding public var date: Date
    let logo: String
    let placeholder: String
    let id: Int
    let scrollViewProxy: ScrollViewProxy
    @State private var isEditing: Bool = false
    
    init(id: Int, scrollViewProxy: ScrollViewProxy, date: Binding<Date>, logo: String = "calendar", placeholder: String = "Date") {
        self.id = id
        self.scrollViewProxy = scrollViewProxy
        self._date = date
        self.logo = logo
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: logo)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 24))
                    .frame(width: UIScreen.screenWidth * 0.05)
                
                Text("Data de nascimento")
                    .foregroundColor(.gray)  // Color of placeholder
                    .font(.custom("Nunito-Light", size: 18)) // Change font here
                    .foregroundColor(.primary)
                    .padding(.leading)
                
                Spacer()
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden() // Hide original DatePicker label
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .id(id)
        }
    }
    
    private func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
