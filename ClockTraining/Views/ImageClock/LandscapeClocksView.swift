//
//  LandscapeClocksView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 11.12.2024.
//

import SwiftUI

struct LandscapeClocksView: View {

    let width: CGFloat
    let height: CGFloat
    @EnvironmentObject var settings: ClockSettings

    var body: some View {
        TimelineView(.everyMinute) { context in
            HStack {
                ClockView(time: Binding.constant(context.date))
                    .frame(width: width * 0.5)
                VStack {
                    Color.clear.frame(height: height * 0.1)
                    DigitalClockView(time: context.date)
                        .frame(height: height * 0.4)
                    TextFromTimeView(selectedLanguage: settings.selectedLanguage,
                                     time: context.date,
                                     roundTime: settings.roundTime)
                    .frame(height: height * 0.5)
                }
            }
        }
    }
}

#Preview {
    let clockSettings = ClockSettings()
    clockSettings.selectedLanguage = Language.en
    clockSettings.roundTime = false
    return LandscapeClocksView(width: 800, height: 400).environmentObject(clockSettings)
}
