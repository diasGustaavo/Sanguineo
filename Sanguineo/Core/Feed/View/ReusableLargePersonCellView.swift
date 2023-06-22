//
//  ReusableLargePersonCellView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 01/06/23.
//

import SwiftUI

struct ReusableLargePersonCellView: View {
    let image: UIImage
    let name: String
    let bloodtype: String
    let age: Int?
    let description: String
    let onButtonPress: () -> Void

    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 8) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(name)
                            .lineLimit(1)
                            .font(.custom("Nunito-Light", size: 20))
                        
                        HStack(spacing: 4) {
                            Image(uiImage: UIImage(named: "bloodtype")!)
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text(bloodtype)
                                .font(.custom("Nunito-Light", size: 20))
                        }
                        
                        if let age = age {
                            Text("Idade: \(age)")
                                .font(.custom("Nunito-Light", size: 13))
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 12)
                
                VStack {
                    Text(description)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.vertical, 12)
                        .font(.custom("Nunito-Light", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Button(action: onButtonPress) {
                    Text("Agendar doação")
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
            .frame(maxWidth: UIScreen.screenWidth - 40)
            .background(Color(uiColor: UIColor(named: "interColor2")!))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        }
        .frame(minHeight: 360)
    }
}

struct ReusableLargePersonCellView_Previews: PreviewProvider {
    static let image = UIImage(named: "3d_avatar_28")!
    static let name = "Luciano Araujo"
    static let bloodtype = "O-"
    static let age: Int? = 22
    static let description = "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro."

    static var previews: some View {
        ReusableLargePersonCellView(image: image, name: name, bloodtype: bloodtype, age: age, description: description) {
            print("button pressed!")
        }
    }
}
