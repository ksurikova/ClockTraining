//
//  ClockView.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 19.11.2024.
//
import SwiftUI

struct ClockAngles {
    static let tickAngle: Double = 6
    static let hourTickAngle: Double = 30
    static let additionalMinuteTickAngle: Double = 0.5
}

struct ClockView: View {

    @Binding var time: Date

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("clock")
                    .resizable()
                    .scaledToFit()
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                HourClockHandView(time: $time).position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                MinuteClockHandView(time: $time).position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                Image("center")
                    .resizable()
                    .scaledToFit()
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}

struct ClockHandView: View {

    @Binding var time: Date
    @State private var angle: Double

    let clockHandImageName: String
    let getAngleFunction: (Date) -> Double

    init(clockHandImageName: String, time: Binding<Date>, getAngleFunction: @escaping (Date) -> Double) {
        self.clockHandImageName = clockHandImageName
        self.getAngleFunction = getAngleFunction
        self._time = time
        self.angle = getAngleFunction(time.wrappedValue)
    }

    var body: some View {
        // Background Image
        Image(clockHandImageName)
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(angle))
            .animation(.linear, value: angle)
            .onChange(of: time) {_, newValue in
                angle = getAngleFunction(newValue)
            }
    }
}

struct MinuteClockHandView: View {
    @Binding var time: Date

    var body: some View {
        ClockHandView(clockHandImageName: "minute_hand", time: $time, getAngleFunction: { x in
            Double(Calendar.current.component(.minute, from: x)) * ClockAngles.tickAngle
        })
    }
}

struct HourClockHandView: View {
    @Binding var time: Date

    var body: some View {
        ClockHandView(clockHandImageName: "hour_hand", time: $time, getAngleFunction: { x in
            Double(Calendar.current.component(.hour, from: x)) * ClockAngles.hourTickAngle +
            Double(Calendar.current.component(.minute, from: x)) * ClockAngles.additionalMinuteTickAngle
        })
    }
}
