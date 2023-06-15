//
//  SettingsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI
import AVFoundation
import CoreLocation

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cameraPermission: Bool = false
    @State private var gpsPermission: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Nunito-Semibold", size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    
                    Text("Termos de uso")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                ScrollView {
                    CustomCell(leftSymbol: "bell", buttonText: "Gerenciar notificações")
                    
                    CustomCell(leftSymbol: "paintpalette", buttonText: "Tema")
                    
                    CustomCell(leftSymbol: "info.circle", buttonText: "Sobre esta versão")
                }
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.async {
                self.cameraPermission = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
                
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager().authorizationStatus {
                    case .authorizedAlways, .authorizedWhenInUse:
                        self.gpsPermission = true
                    default:
                        self.gpsPermission = false
                    }
                } else {
                    self.gpsPermission = false
                }
            }
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}