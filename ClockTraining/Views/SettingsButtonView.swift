//
//  SettingsButtonView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 11.12.2024.
//

import SwiftUI

struct SettingsButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: colorScheme == .dark ? "gearshape.fill" : "gearshape")
                .padding()
                .dynamicTypeSize(.medium)
        }
    }
}

#Preview {
    SettingsButtonView(action: {})
}
