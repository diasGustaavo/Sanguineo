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
                .frame(width: 40, height: 40)

            Text(address)
                .font(.custom("Nunito-Light", size: 16))
                .lineLimit(2)
                .truncationMode(.tail)
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
