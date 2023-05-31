//
//  ReusableHospitalCellView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 31/05/23.
//

import SwiftUI

struct ReusableHospitalCellView: View {
    @Binding public var image: UIImage
    @Binding public var name: String
    @Binding public var bloodtype: String
    @Binding public var description: String
    var onButtonPress: () -> Void

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
                        .fixedSize(horizontal: false, vertical: true) // add this line
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
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor, lineWidth: 0.8)
            )
        }
        .frame(minHeight: 240)
    }
}

struct ReusableHospitalCellView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "3d_avatar_28_hospital")!
    @State static var name = "Hemocentro"
    @State static var bloodtype = "O-"
    @State static var description = "Precisamos urgente de sangue O+ para inúmeros pacientes"

    static var previews: some View {
        ReusableHospitalCellView(image: $image, name: $name, bloodtype: $bloodtype, description: $description) {
            print("button pressed!")
        }
    }
}
