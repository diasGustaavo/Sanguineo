//
//  AddressSearchedItemView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 14/06/23.
//

import SwiftUI

struct AddressSearchedItemView: View {
    let address: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(width: 30, height: 30)

            Text(address)
                .font(.custom("Nunito-Light", size: 18))
                .lineLimit(2)
                .truncationMode(.tail)
            
            Spacer()
        }
    }
}

struct AddressSearchedItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchedItemView(address: "123 Long Street Name, Really Long City Name, Very Long State Name, Country")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
