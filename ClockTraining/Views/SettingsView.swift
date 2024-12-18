//
//  SettingsView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 11.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: ClockSettings
    var body: some View {
        VStack {
            Text("Language")
            Picker("", selection: $settings.selectedLanguage) {
                ForEach(Language.allCases) { lang in
                    Text(lang.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            Toggle("Round to 5 minutes", isOn: $settings.roundTime)
        }
        .padding()
        .fixedSize()
        .background(Color(.popoverBackground))
        .cornerRadius(5)
    }
}

#Preview {
    let clockSettings = ClockSettings()
    clockSettings.selectedLanguage = Language.en
    clockSettings.roundTime = false
    return SettingsView().environmentObject(clockSettings)
}
