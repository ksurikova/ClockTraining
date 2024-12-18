//
//  NaturalLanguageEnTimeFormatter.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 29.11.2024.
//
import Foundation

struct NaturalLanguageEnTimeFormatter: NaturalLanguageTimeFormatter {

    private let numbersAsText: [Int: String] = [
        1: "one", 2: "two", 3: "three", 4: "four",
        5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine",
        10: "ten", 11: "eleven", 12: "twelve", 13: "thirteen", 14: "fourteen", 15: "quarter",
        16: "sixteen", 17: "seventeen", 18: "eighteen", 19: "nineteen", 30: "half"
    ]

    private func getAffix(caseToDo: HourCase) -> String {
        switch caseToDo {
        case .moreThanHalf: "to"
        case .lessThanHalf: "past"
        case .sharp: ""
        case .half: "past"
        }
    }

    private func getMinutesAffix(_ halfMinutes: Int) throws -> String {
        guard halfMinutes >= 0 && halfMinutes <= 30 else {
            throw NaturalLanguageFormatterError.invalidHalfMinute(halfMinutes)
        }
        if halfMinutes == 1 {
            return "minute"
        } else if halfMinutes != 15 && halfMinutes != 30 {
            return "minutes"
        } else {
            return ""
        }
    }

    private func convertMinutesToText(_ minute: Int) throws -> String {
        guard minute != 0 else {
            return ""
        }
        guard minute > 0 && minute < 60 else {
            throw NaturalLanguageFormatterError.invalidMinute(minute)
        }
        let halfMinutes = minute > 30 ?  60 - minute : minute
        var minutesValue: String = ""

        if let word = numbersAsText[halfMinutes] {
            minutesValue = word
        } else {
            // Handle minites 20...29
            let units = halfMinutes % 10
            minutesValue = "twenty \(numbersAsText[units] ?? "")"
        }
        let parts: [String] = [minutesValue, try getMinutesAffix(halfMinutes)]
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
        case .moreThanHalf: hour + 1 == 24 ?  numbersAsText[12]!: numbersAsText[hourByTwelwe+1]!
        case .lessThanHalf: numbersAsText[hourByTwelwe]!
        case .half: numbersAsText[hourByTwelwe]!
        case .sharp: numbersAsText[hourByTwelwe]! +  " o'clock"
        }
        return hourString
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
        let parts: [String] = ["It is", minutes, getAffix(caseToDo: caseToDo), hours]
        return parts.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
