//
//  NaturalLanguageRuTimeFormatter.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 29.11.2024.
//
import Foundation

struct NaturalLanguageRuTimeFormatter: NaturalLanguageTimeFormatter {

    private func getAffix(caseToDo: HourCase) -> String {
        switch caseToDo {
        case .moreThanHalf: "без"
        case .lessThanHalf: ""
        case .sharp: ""
        case .half: "половина"
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
        let minutesAffix = try getMinutesAffix(minute)
        let parts: [String] = ["Сейчас", affix, minutes, minutesAffix, hours]
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
        case .moreThanHalf: hourByTwelwe == 12 ?  hoursAsText[1]?.0 : hoursAsText[hourByTwelwe+1]?.0
        case .lessThanHalf: hourByTwelwe == 12 ?  hoursAsText[1]?.1 : hoursAsText[hourByTwelwe+1]?.1
        case .sharp: hoursAsText[hourByTwelwe]?.0
        case .half:  hour + 1 == 24 ?  hoursAsText[12]?.1 : hoursAsText[hourByTwelwe+1]?.1
        }
        if let hourString {
            let affix  = caseToDo == .sharp ? try getHourAffix(hourByTwelwe: hourByTwelwe, pm: hour >= 12): ""
            return affix.isEmpty ? hourString : hourString + " " + affix
        } else { return "" }
    }

    private func getHourAffix(hourByTwelwe: Int, pm: Bool) throws -> String {
        guard hourByTwelwe > 0 && hourByTwelwe <= 12 else { throw NaturalLanguageFormatterError.invalidHour(hourByTwelwe) }
        let hourWord = if hourByTwelwe == 1 {
            ""
        } else if hourByTwelwe < 5 {
            "часа "
        } else {
            "часов "
        }
        var timeOfDay: String
        if hourByTwelwe < 5 || hourByTwelwe == 12 {
            timeOfDay = pm ? "дня" : "ночи"
        } else {
            timeOfDay = pm ?  "вечера": "утра"
        }
        return hourWord + timeOfDay
    }

    private let minutesAsText: [Int: (String, String)] = [
        1: ("одна", "одной"),
        2: ("две", "двух"),
        3: ("три", "трёх"),
        4: ("четыре", "четырёх"),
        5: ("пять", "пяти"),
        6: ("шесть", "шести"),
        7: ("семь", "семи"),
        8: ("восемь", "восьми"),
        9: ("девять", "девяти"),
        10: ("десять", "десяти"),
        11: ("одиннадцать", "одиннадцати"),
        12: ("двенадцать", "двенадцати"),
        13: ("тринадцать", "тринадцати"),
        14: ("четырнадцать", "четырнадцати"),
        15: ("пятнадцать", "пятнадцати"),
        16: ("шестнадцать", "шестнадцати"),
        17: ("семнадцать", "семнадцати"),
        18: ("восемнадцать", "восемнадцати"),
        19: ("девятнадцать", "девятнадцати"),
        20: ("двадцать", "двадцати")]

    private let hoursAsText: [Int: (String, String)] = [
        1: ("час", "первого"),
        2: ("два", "второго"),
        3: ("три", "третьего"),
        4: ("четыре", "четвертого"),
        5: ("пять", "пятого"),
        6: ("шесть", "шестого"),
        7: ("семь", "седьмого"),
        8: ("восемь", "восьмого"),
        9: ("девять", "девятого"),
        10: ("десять", "десятого"),
        11: ("одиннадцать", "одиннадцатого"),
        12: ("двенадцать", "двенадцатого")]

    private func getMinutesAffix(_ minutes: Int) throws -> String {
        guard minutes != 0 else {
            return ""
        }
        guard minutes != 30 else {
            return ""
        }
        guard minutes >= 0 && minutes < 60 else {
            throw NaturalLanguageFormatterError.invalidMinute(minutes)
        }
        let tens = minutes / 10
        if tens >= 3 {
            if minutes == 59 || minutes == 39 {
                return "минуты"
            } else { return "минут" }
        } else if tens == 1 {
            return "минут"
        } else {
            let units = minutes % 10
            if units == 0 {
                return "минут"
            } else if units == 1 {
                return "минута"
            } else if units < 5 {
                return "минуты"
            } else {
                return "минут"
            }
        }
    }

    private func convertMinutesToText(_ minute: Int) throws -> String {
        guard minute != 0 else {
            return ""
        }
        guard minute != 30 else {
            return ""
        }
        guard minute > 0 && minute < 60 else {
            throw NaturalLanguageFormatterError.invalidMinute(minute)
        }
        var minutesValue: String = ""
        let isMoreThanHalf = minute > 30
        let halfMinutes = isMoreThanHalf ?  60 - minute : minute

        if let word = isMoreThanHalf ? minutesAsText[halfMinutes]?.1 : minutesAsText[halfMinutes]?.0 {
            minutesValue = word
        } else {
            // Handle minites 20...29
            minutesValue = isMoreThanHalf ? "двадцати" : "двадцать"
            let units = halfMinutes % 10
            if units != 0 {
                let unitsWord = isMoreThanHalf ? minutesAsText[units]?.1 : minutesAsText[units]?.0
                minutesValue = minutesValue + " " + (unitsWord ?? "")
            }
        }
        return minutesValue
    }
}
