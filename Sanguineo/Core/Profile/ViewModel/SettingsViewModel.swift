//
//  SettingsViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 16/06/23.
//

import Combine
import UIKit

class SettingsViewModel: ObservableObject {
    @Published var appNotifications: Bool
    @Published var mailNotifications: Bool
    @Published var phoneNotifications: Bool
    @Published var theme: String {
        didSet {
            UserDefaults.standard.set(theme, forKey: "theme")
            applyTheme(theme: theme)
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        appNotifications = UserDefaults.standard.bool(forKey: "appNotifications")
        mailNotifications = UserDefaults.standard.bool(forKey: "mailNotifications")
        phoneNotifications = UserDefaults.standard.bool(forKey: "phoneNotifications")
        theme = UserDefaults.standard.string(forKey: "theme") ?? "system"
        
        $appNotifications
            .sink { newValue in
                UserDefaults.standard.set(newValue, forKey: "appNotifications")
            }
            .store(in: &cancellables)
        
        $mailNotifications
            .sink { newValue in
                UserDefaults.standard.set(newValue, forKey: "mailNotifications")
            }
            .store(in: &cancellables)
        
        $phoneNotifications
            .sink { newValue in
                UserDefaults.standard.set(newValue, forKey: "phoneNotifications")
            }
            .store(in: &cancellables)
    }
    
    func applyTheme(theme: String) {
        switch theme {
        case "dark":
            toggleDarkMode()
        case "white":
            toggleWhiteMode()
        default:
            toggleSystemMode()
        }
    }
    
    private func toggleDarkMode() {
        if let firstWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            firstWindow.windows.first?.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func toggleWhiteMode() {
        if let firstWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            firstWindow.windows.first?.overrideUserInterfaceStyle = .light
        }
    }
    
    private func toggleSystemMode() {
        if let firstWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            firstWindow.windows.first?.overrideUserInterfaceStyle = .unspecified
        }
    }
}
