//
//  PortraitClocksView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 11.12.2024.
//

import SwiftUI

struct PortraitClocksView: View {

    let height: CGFloat
    @EnvironmentObject var settings: ClockSettings

    var body: some View {
        TimelineView(.everyMinute) { context in
            VStack {
                ClockView(time: Binding.constant(context.date))
                    .frame(height: height * 0.4)
                DigitalClockView(time: context.date)
                    .frame(height: height * 0.3)
                TextFromTimeView(selectedLanguage: settings.selectedLanguage,
                                 time: context.date,
                                 roundTime: settings.roundTime)
                .frame(height: height * 0.3)
            }
        }
    }
}

#Preview {
    let clockSettings = ClockSettings()
    clockSettings.selectedLanguage = Language.en
    clockSettings.roundTime = false
    return PortraitClocksView(height: 400).environmentObject(clockSettings)
}
