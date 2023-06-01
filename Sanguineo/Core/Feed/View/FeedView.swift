//
//  FeedView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI

struct FeedView: View {
    @State var image = UIImage(named: "3d_avatar_28")!
    @State var name = "Luciano Araujo"
    @State var bloodtype = "O-"
    @State var age = 22
    @State var description = "Sofri um acidente e nao tenho doadores que possam me ajudar onde eu moro."
    
    @State var imageHospital = UIImage(named: "3d_avatar_28_hospital")!
    @State var nameHospital = "Hemocentro"
    @State var bloodtypeHospital = "O-"
    @State var descriptionHospital = "Precisamos urgente de sangue O+ para inúmeros pacientes"
    
    var body: some View {
        ScrollView {
            // HEADER
            HStack {
                Image(uiImage: UIImage(named: "bloodtype")!)
                    .resizable()
                    .frame(width: 30 ,height: 30)
                
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
            
            // FILTERS
            HStack {
                Button {
                    // some action
                } label: {
                    HStack {
                        Image(systemName: "line.horizontal.3.decrease")
                            .padding(.leading)
                        
                        Text("Filtros")
                            .font(.custom("Nunito-Regular", size: 14))
                            .frame(height: 40)
                            .foregroundColor(Color.black)
                            .padding(.trailing)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                    )
                }
                
                Spacer()
                
                Button {
                    // some action
                } label: {
                    Text("Mais Próximos")
                        .font(.custom("Nunito-Regular", size: 14))
                        .multilineTextAlignment(.center)
                        .frame(height: 40)
                        .foregroundColor(Color.black)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                        )
                }
                
                Spacer()
                
                Button {
                    // some action
                } label: {
                    Text("Urgência")
                        .font(.custom("Nunito-Regular", size: 14))
                        .multilineTextAlignment(.center)
                        .frame(height: 40)
                        .padding(.horizontal)
                        .foregroundColor(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 22)
            
            HStack {
                Text("Essas pessoas precisam de sua ajuda")
                    .font(.custom("Nunito-Bold", size: 18))
                    .multilineTextAlignment(.leading)
                
                Spacer().frame(width: 100)
                
                Button {
                    // some action
                } label: {
                    Text("Expandir")
                        .font(.custom("Nunito-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<3) { _ in
                        ReusablePersonCellView(image: $image, name: $name, bloodtype: $bloodtype, age: $age, description: $description) {
                            print("Button pressed!")
                        }
                    }
                }
                .padding(.vertical)
            }
            .padding(.leading, 16)
            
            HStack {
                Text("Campanhas de doações")
                    .font(.custom("Nunito-Bold", size: 18))
                    .multilineTextAlignment(.leading)
                
                Spacer().frame(width: 100)
                
                Button {
                    // some action
                } label: {
                    Text("Expandir")
                        .font(.custom("Nunito-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<3) { _ in
                        ReusableHospitalCellView(image: $imageHospital, name: $nameHospital, bloodtype: $bloodtypeHospital, description: $descriptionHospital) {
                            print("Button pressed!")
                        }
                    }
                }
                .padding(.vertical)
            }
            .padding(.leading, 16)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
