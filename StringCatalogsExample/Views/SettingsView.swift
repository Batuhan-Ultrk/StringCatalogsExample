//
//  SettingsView.swift
//  StringCatalogsExample
//
//  Created by Batuhan Ulutürk on 19.01.2026.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            // "SettingsViewLocalizable.xcstrings" dosyasındaki "settings_title" anahtarını okur
            Text("settings_title".localized(table: .settingsView))
                .font(.title)

            Button {
                // Action
            } label: {
                // "Shared.xcstrings" dosyasındaki ortak "save_button" anahtarını okur
                Text("save_button".localized(table: .shared))
            }
        }
        // "SettingsViewLocalizable.xcstrings" dosyasındaki "navigation_title" anahtarını okur
        .navigationTitle(
            "navigation_title".localized(table: .settingsView)
        )
    }
}
