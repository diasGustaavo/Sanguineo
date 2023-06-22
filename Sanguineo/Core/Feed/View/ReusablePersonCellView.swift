//
//  ReusableCellView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 31/05/23.
//

import SwiftUI

struct ReusablePersonCellView: View {
    let image: UIImage
    let name: String
    let bloodtype: String
    let age: Int?
    let description: String
    let onButtonPress: () -> Void

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading) {
                        Text(name)
                            .lineLimit(1)
                            .font(.custom("Nunito-Light", size: 15))
                        
                        HStack {
                            Image(uiImage: UIImage(named: "bloodtype")!)
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            Text(bloodtype)
                                .font(.custom("Nunito-Light", size: 15))
                        }
                        
                        if let age = age {
                            Text("Idade: \(age)")
                                .font(.custom("Nunito-Light", size: 13))
                        }
                    }
                    Spacer()
                }
                .padding(.all, 8)
                
                VStack {
                    Text(description)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.vertical, 8)
                        .font(.custom("Nunito-Light", size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Button(action: onButtonPress) {
                    Text("Agendar doação")
                        .padding(.horizontal, 13)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                }
                .padding(.horizontal, 13)
            }
            .padding(.vertical)
            .padding(.horizontal, 8)
            .frame(maxWidth: 240)
            .background(Color(uiColor: UIColor(named: "interColor2")!))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor, lineWidth: 0.8)
            )
        }
        .frame(minHeight: 240)
    }
}

struct ReusablePersonCellView_Previews: PreviewProvider {
    static let image = UIImage(named: "3d_avatar_28")!
    static let name = "Luciano Araujo"
    static let bloodtype = "O-"
    static let age: Int? = 22
    static let description = "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro."

    static var previews: some View {
        ReusablePersonCellView(image: image, name: name, bloodtype: bloodtype, age: age, description: description) {
            print("button pressed!")
        }
    }
}
