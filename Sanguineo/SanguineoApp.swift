//
//  SanguineoApp.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SanguineoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewModel())
                .environmentObject(InitialLogViewModel())
                .environmentObject(AddressViewModel())
                .environmentObject(SettingsViewModel())
                .environmentObject(ProfileViewModel(image: Image(uiImage: UIImage(named: "3d_avatar_28")!), name: "guga", fakeName: "liz taylor", email: "diasgustaavo@icloud.com", phone: "(83) 98147-4782", CEP: "58073343", neighborhood: "Cidade dos Colibris", street: "Rua Simas Turbo", number: "69", complement: "22", gender: 0, bloodtype: "0+"))
        }
    }
}
