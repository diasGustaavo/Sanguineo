//
//  StringCapitalizingFirstLetter.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 13/06/23.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
