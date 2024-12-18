//
//  ContentView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 19.11.2024.
//

import SwiftUI

class ClockSettings: ObservableObject {
    @AppStorage("selectedLanguage") var selectedLanguage: Language = .en
    @AppStorage("roundTime")  var roundTime: Bool = true
}

struct ContentView: View {
    
    @State private var isOpenSettings: Bool = false
    @StateObject private var settings = ClockSettings()
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            GeometryReader { geometry in
                // clock representations
                if geometry.size.height > geometry.size.width {
                    PortraitClocksView(height: geometry.size.height)
                        .environmentObject(settings)
                } else {
                    LandscapeClocksView(width: geometry.size.width, height: geometry.size.height)
                        .environmentObject(settings)
                }
            }
            .onTapGesture {
                isOpenSettings = false
            }
            SettingsButtonView(action: { isOpenSettings = true })
            if isOpenSettings {
                SettingsView()
                    .environmentObject(settings)
            }
        }
    }
}

#Preview {
    ContentView()
}
