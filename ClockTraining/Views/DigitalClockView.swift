//
//  DigitalClockView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 19.11.2024.
//
import SwiftUI

struct DigitalClockView: View {
    let time: Date

    var minutes: Int {Calendar.current.component(.minute, from: time)}
    var hours: Int {Calendar.current.component(.hour, from: time)}

    var timeInString: String {
        String(format: "%02d:%02d", hours, minutes)
    }

    var body: some View {
        Text(timeInString)
            .font(
                .system(size: 250)
                .monospacedDigit()
            ).minimumScaleFactor(0.04)
    }
}
