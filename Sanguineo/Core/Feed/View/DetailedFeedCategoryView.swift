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
    
    @EnvironmentObject var addressViewModel: AddressViewModel
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    @EnvironmentObject var feedViewModel: FeedViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @GestureState private var dragOffset = CGSize.zero
    @State private var showingAddressView = false
    
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
                    
                    Text(initialLogViewModel.currentUser?.bloodtype ?? "")
                        .font(.custom("Nunito-Regular", size: 16))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text((addressViewModel.selectedAddress?.street.map { String($0.prefix(22)) + ($0.count > 25 ? "..." : "") } ?? "Sem endereço selecionado"))
                        .font(.custom("Nunito-Light", size: 16))
                        .multilineTextAlignment(.center)
                        .onTapGesture {
                            showingAddressView = true
                        }
                        .sheet(isPresented: $showingAddressView) {
                            AddressView()
                        }
                    
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
                
                if (!feedViewModel.individualsLoading) && (!feedViewModel.hospitalsLoading) {
                    ForEach(requesters, id: \.id) { requester in
                        ReusableLargePersonCellView(image: requester.image, name: requester.name, bloodtype: requester.bloodtype, age: (requester as? Individual)?.age, description: requester.description) {
                            print("Button pressed!")
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                            .frame(height: 40)
                        
                        Spinner(lineWidth: 5, height: 32, width: 32)
                        
                        Spacer()
                            .frame(height: 20)
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
    static let acidente = true
    static let cirurgia = false
    static let doenca = true
    static let outro = false
    static let tratamento = false
    static let individual = Individual(authorId: UUID().uuidString, id: UUID().uuidString, name: name, bloodtype: bloodtype, age: age!, description: description, coordinateX: 0.0, coordinateY: 0.0, acidente: acidente, cirurgia: cirurgia, doenca: doenca, outro: outro, tratamento: tratamento, image: UIImage(named: "3d_avatar_28")!)
    static let hospital = Hospital(authorId: UUID().uuidString, id: UUID().uuidString, name: name, bloodtype: bloodtype, description: description, coordinateX: 0.0, coordinateY: 0.0, acidente: acidente, cirurgia: cirurgia, doenca: doenca, outro: outro, tratamento: tratamento, image: UIImage(named: "3d_avatar_28")!)

    static var previews: some View {
        DetailedFeedCategoryView(sectionDescription: "Essas pessoas precisam de sua ajuda:", requesters: [individual, hospital]) {
            print("button pressed!")
        }
    }
}
