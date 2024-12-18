//
//  TextFromTimeView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 10.12.2024.
//

import SwiftUI

struct TextFromTimeView: View {

    let selectedLanguage: Language
    let time: Date
    let roundTime: Bool

    var body: some View {
        Text(selectedLanguage.formatter.format(date: time,
                                               letsRoundToNearestFiveMinutes: roundTime))
        .font(.system(size: 100)).minimumScaleFactor(0.1)
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    TextFromTimeView(selectedLanguage: .tr,
                     time: { let f = DateFormatter(); f.dateFormat = "HH:mm"; return f }().date(from: "15:30") ?? Date(),
                     roundTime: false)
}
