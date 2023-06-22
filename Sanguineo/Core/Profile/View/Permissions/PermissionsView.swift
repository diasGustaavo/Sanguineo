//
//  PermissionsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI
import AVFoundation

struct PermissionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cameraPermission: Bool = false
    @ObservedObject private var locationManager = LocationManager()
    
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
                    
                    Text("Permissões do app")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                HStack {
                    Image(systemName: cameraPermission ? "checkmark.circle" : "xmark.circle")
                        .padding(.trailing)
                        .font(.custom("Nunito-SemiBold", size: 24))
                        .if(cameraPermission, transform: { view in
                            view.foregroundColor(.accentColor)
                        })
                        .if(!cameraPermission, transform: { view in
                            view.foregroundColor(.red)
                        })
                    
                    VStack {
                        HStack {
                            Text("Câmera")
                                .font(.custom("Nunito-Regular", size: 20))
                            
                            Spacer()
                        }
                        .padding(.vertical, 2)
                        
                        HStack {
                            Text("Nós utilizamos a câmera para realizar o processo de triagem.")
                                .font(.custom("Nunito-Light", size: 16))
                            
                            Spacer()
                        }
                        .padding(.bottom, 2)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 0.8)
                )
                .padding()
                .padding(.horizontal, 4)
                
                Button {
                    locationManager.requestLocationPermission()
                } label: {
                    HStack {
                        Image(systemName: gpsPermission ? "checkmark.circle" : "xmark.circle")
                            .padding(.trailing)
                            .font(.custom("Nunito-SemiBold", size: 24))
                            .if(gpsPermission, transform: { view in
                                view.foregroundColor(.accentColor)
                            })
                            .if(!gpsPermission, transform: { view in
                                view.foregroundColor(.red)
                            })
                        
                        VStack {
                            HStack {
                                Text("Localização")
                                    .font(.custom("Nunito-Regular", size: 20))
                                
                                Spacer()
                            }
                            .padding(.vertical, 2)
                            
                            HStack {
                                Text("Nós utilizamos o GPS para localizar Hemocentros perto de sua localização")
                                    .font(.custom("Nunito-Light", size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(.bottom, 2)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor, lineWidth: 0.8)
                    )
                    .padding(.horizontal)
                    .padding(.horizontal, 4)
                }
                .foregroundColor(.black)

                
                Spacer()
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.async {
                self.cameraPermission = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
            }
        })
    }
    
    var gpsPermission: Bool {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
}

struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView()
    }
}
