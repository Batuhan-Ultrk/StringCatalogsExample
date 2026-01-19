//
//  LoginView.swift
//  StringCatalogsExample
//
//  Created by Batuhan Ulutürk on 19.01.2026.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            // "LoginViewLocalizable.xcstrings" dosyasındaki "welcome_text" anahtarını okur
            Text("welcome_text".localized(table: .loginView))
                .font(.title)
            
            Button {
                // Action
            } label: {
                // "SharedLocalizable.xcstrings" dosyasındaki ortak "login_button" anahtarını okur
                Text("login_button".localized(table: .shared))
            }

            NavigationLink(destination: SettingsView()) {
                // "LoginViewLocalizable.xcstrings" dosyasındaki "navigate_settings_view" anahtarını okur
                Text("navigate_settings_view".localized(table: .loginView))
            }
        }
        // "LoginViewLocalizable.xcstrings" dosyasındaki "navigation_title" anahtarını okur
        .navigationTitle(
            "navigation_title".localized(table: .loginView)
        )
    }
}
