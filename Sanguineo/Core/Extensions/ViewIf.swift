//
//  ViewIf.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 13/06/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool, transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
