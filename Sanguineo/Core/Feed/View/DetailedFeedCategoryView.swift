//
//  DetailedFeedCategoryView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 01/06/23.
//

import SwiftUI

struct DetailedFeedCategoryView: View {
    let sectionDescription: String
    
    let image: UIImage
    let name: String
    let bloodtype: String
    let age: Int?
    let description: String
    let onButtonPress: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    init(sectionDescription: String, image: UIImage, name: String, bloodtype: String, description: String, age: Int? = nil, onButtonPress: @escaping () -> Void) {
        self.sectionDescription = sectionDescription
        self.image = image
        self.name = name
        self.bloodtype = bloodtype
        self.description = description
        self.onButtonPress = onButtonPress
        self.age = age
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                // HEADER
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Nunito-Semibold", size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                            .padding(.trailing)
                    }

                    Image(uiImage: UIImage(named: "bloodtype")!)
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("O-")
                        .font(.custom("Nunito-Regular", size: 16))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("Rua Empresario Manoel...")
                        .font(.custom("Nunito-Light", size: 16))
                        .multilineTextAlignment(.center)
                    
                    Image(systemName: "chevron.down")
                        .font(.custom("Nunito-Light", size: 14))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Image(systemName: "bell")
                        .font(.custom("Nunito-Semibold", size: 20))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 16)
                
                HStack {
                    Text(sectionDescription)
                        .font(.custom("Nunito-Bold", size: 18))
                        .multilineTextAlignment(.leading)
                    
                    Spacer().frame(width: 150)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                if let age = age {
                    ForEach(0..<3) { _ in
                        ReusableLargePersonCellView(image: image, name: name, bloodtype: bloodtype, age: age, description: description) {
                            print("Button pressed!")
                        }
                    }
                } else {
                    ForEach(0..<3) { _ in
                        ReusableLargePersonCellView(image: image, name: name, bloodtype: bloodtype, age: nil, description: description) {
                            print("Button pressed!")
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailedFeedCategoryView_Previews: PreviewProvider {
    static let image = UIImage(named: "3d_avatar_28")!
    static let name = "Luciano Araujo"
    static let bloodtype = "O-"
    static let age: Int? = 22
    static let description = "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro."

    static var previews: some View {
        DetailedFeedCategoryView(sectionDescription: "Essas pessoas precisam de sua ajuda:", image: image, name: name, bloodtype: bloodtype, description: description) {
            print("button pressed!")
        }
    }
}
