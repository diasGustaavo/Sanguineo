//
//  InitialLogView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 23/05/23.
//

import Combine
import SwiftUI

class InitialLogViewModel: ObservableObject {
    @Published var isLoginViewActive: Bool = false
    @Published var isRegisterViewActive: Bool = false
}
