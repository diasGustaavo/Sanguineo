//
//  DetailedFeedCategoryView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 01/06/23.
//

import SwiftUI

struct DetailedFeedCategoryView: View {
    let sectionDescription: String
    let requesters: [RequesterInfo]
    let onButtonPress: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    @GestureState private var dragOffset = CGSize.zero

    init(sectionDescription: String, requesters: [RequesterInfo], onButtonPress: @escaping () -> Void) {
        self.sectionDescription = sectionDescription
        self.requesters = requesters
        self.onButtonPress = onButtonPress
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
                
                ForEach(requesters, id: \.name) { requester in
                    ReusableLargePersonCellView(image: requester.image, name: requester.name, bloodtype: requester.bloodtype, age: (requester as? Individual)?.age, description: requester.description) {
                        print("Button pressed!")
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }))
    }
}

struct DetailedFeedCategoryView_Previews: PreviewProvider {
    static let image = UIImage(named: "3d_avatar_28")!
    static let name = "Luciano Araujo"
    static let bloodtype = "O-"
    static let age: Int? = 22
    static let description = "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro."
    static let individual = Individual(image: image, name: name, bloodtype: bloodtype, age: age!, description: description)
    static let hospital = Hospital(image: image, name: "Hospital", bloodtype: bloodtype, description: "We urgently need O+ blood for several patients.")

    static var previews: some View {
        DetailedFeedCategoryView(sectionDescription: "Essas pessoas precisam de sua ajuda:", requesters: [individual, hospital]) {
            print("button pressed!")
        }
    }
}
