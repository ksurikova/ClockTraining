//
//  NaturalLanguageTrTimeFormatter.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 29.11.2024.
//
import Foundation

struct NaturalLanguageTrTimeFormatter: NaturalLanguageTimeFormatter {

    struct HourAsText {
        let usual: String
        let forLessHalf: String
        let forMoreHalf: String
    }

    private func getAffix(caseToDo: HourCase) -> String {
        switch caseToDo {
        case .moreThanHalf: "var"
        case .lessThanHalf: "geçiyor"
        case .sharp: ""
        case .half: ""
        }
    }

    func formatWhichCanThrow(date: Date) throws -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        guard let hour = components.hour, let minute = components.minute else {
            throw NaturalLanguageFormatterError.invalidTime(components)
        }
        let caseToDo = getHourCase(minute: minute)
        let minutes = try convertMinutesToText(minute)
        let hours = try convertHoursToText(hour, caseToDo: caseToDo)
        let affix = getAffix(caseToDo: caseToDo)
        let parts: [String] = ["Saat", hours, minutes, affix]
        return parts.filter { !$0.isEmpty }.joined(separator: " ")
    }

    private func convertHoursToText(_ hour: Int, caseToDo: HourCase) throws -> String {
        guard hour >= 0 && hour < 24 else { throw NaturalLanguageFormatterError.invalidHour(hour) }
        let hourByTwelwe = if hour == 0 {
            12 } else {
                if hour > 12 {
                    hour - 12
                } else { hour }
            }
        let hourString =
        switch caseToDo {
        case .moreThanHalf: hour + 1 == 24 ?  hoursAsText[12]?.forMoreHalf : hoursAsText[hourByTwelwe+1]?.forMoreHalf
        case .lessThanHalf: hoursAsText[hourByTwelwe]?.forLessHalf
        case .sharp: hoursAsText[hourByTwelwe]?.usual
        case .half: hoursAsText[hourByTwelwe]?.usual
        }
        return hourString ?? ""
    }

    private let minutesAsText: [Int: String] = [
        1: "bir", 2: "iki", 3: "üç", 4: "dört",
        5: "beş", 6: "altı", 7: "yedi", 8: "sekiz", 9: "dokuz",
        15: "çeyrek", 30: "buçuk"]

    private let hoursAsText: [Int: HourAsText] = [
        1: HourAsText(usual: "bir", forLessHalf: "biri", forMoreHalf: "bire"),
        2: HourAsText(usual: "iki", forLessHalf: "ikiyi", forMoreHalf: "ikiye"),
        3: HourAsText(usual: "üç", forLessHalf: "üçü", forMoreHalf: "üçe"),
        4: HourAsText(usual: "dört", forLessHalf: "dördü", forMoreHalf: "dörde"),
        5: HourAsText(usual: "beş", forLessHalf: "beşi", forMoreHalf: "beşe"),
        6: HourAsText(usual: "altı", forLessHalf: "altıyı", forMoreHalf: "altıya"),
        7: HourAsText(usual: "yedi", forLessHalf: "yediyi", forMoreHalf: "yediye"),
        8: HourAsText(usual: "sekiz", forLessHalf: "sekizi", forMoreHalf: "sekize"),
        9: HourAsText(usual: "dokuz", forLessHalf: "dokuzu", forMoreHalf: "dokuza"),
        10: HourAsText(usual: "on", forLessHalf: "onu", forMoreHalf: "ona"),
        11: HourAsText(usual: "on bir", forLessHalf: "on biri", forMoreHalf: "on bire"),
        12: HourAsText(usual: "on iki", forLessHalf: "on ikiyi", forMoreHalf: "on ikiye")]

    private let tensAsText: [Int: String] = [
        1: "on", 2: "yirmi"
    ]

    private func convertMinutesToText(_ minute: Int) throws -> String {
        guard minute != 0 else {
            return ""
        }
        guard minute > 0 && minute < 60 else {
            throw NaturalLanguageFormatterError.invalidMinute(minute)
        }
        var minutesValue: String = ""
        let halfMinutes = minute > 30 ?  60 - minute : minute

        if let word = minutesAsText[halfMinutes] {
            minutesValue = word
        } else {
            let tens =  halfMinutes / 10
            let tensWord = tensAsText[tens] ?? ""
            let units = halfMinutes % 10
            minutesValue = "\(tensWord) \(minutesAsText[units] ?? "")"
        }
        return minutesValue
    }
}
