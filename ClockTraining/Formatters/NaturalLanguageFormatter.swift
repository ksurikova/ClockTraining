//
//  TimeFormatter.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 22.11.2024.
//
import Foundation

enum Language: String, CaseIterable, Identifiable {
    case en
    case ru
    case tr
    var id: Self { self }

    var formatter: NaturalLanguageTimeFormatter {
        switch self {
        case .en:
            return NaturalLanguageEnTimeFormatter()
        case .ru:
            return NaturalLanguageRuTimeFormatter()
        case .tr:
            return NaturalLanguageTrTimeFormatter()
        }
    }
}

enum HourCase {
    case moreThanHalf
    case lessThanHalf
    case sharp
    case half
}

enum NaturalLanguageFormatterError: LocalizedError {
    case invalidMinute(_ minute: Int)
    case invalidHour(_ hour: Int)
    case invalidTime(_ timeComponents: DateComponents)
    case invalidHalfMinute(_ halfMinute: Int)
    case invalidRoundedTime(_ timeComponents: DateComponents)

    var errorDescription: String? {
        switch self {
        case .invalidMinute(let minute):
            return "Invalid minite value \(minute)"
        case .invalidHalfMinute(let halfMinute):
            return "Invalid minite value \(halfMinute), if should be less than half of hour"
        case .invalidHour(let hour):
            return "Invalid hour value \(hour)"
        case .invalidTime(let timeComponents):
            return "Invalid time value \(timeComponents)"
        case .invalidRoundedTime(let timeComponents):
            return "Invalid rounded time value \(timeComponents)"
        }
    }
}

protocol NaturalLanguageTimeFormatter {
    func formatWhichCanThrow(date: Date) throws -> String
    func format(date: Date, letsRoundToNearestFiveMinutes: Bool) -> String
}

extension NaturalLanguageTimeFormatter {

    func format(date: Date, letsRoundToNearestFiveMinutes: Bool = false) -> String {
        do {
            if letsRoundToNearestFiveMinutes {
                let roundedDate = try roundToNearestFiveMinutes(from: date)
                return try self.formatWhichCanThrow(date: roundedDate)
            } else {
                return try self.formatWhichCanThrow(date: date)
            }
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }

    func getHourCase(minute: Int) -> HourCase {
        if minute > 30 {
            .moreThanHalf
        } else if minute == 0 {
            .sharp
        } else if minute == 30 {
            .half
        } else {
            .lessThanHalf
        }
    }

    func roundToNearestFiveMinutes(from date: Date) throws -> Date {
        let calendar = Calendar.current

        let components = calendar.dateComponents([.hour, .minute], from: date)
        guard let hour = components.hour, let minute = components.minute else {
            throw NaturalLanguageFormatterError.invalidTime(components)
        }

        let totalMinutes = hour * 60 + minute
        let roundedMinutes = ((totalMinutes + 2) / 5) * 5

        let roundedHour = roundedMinutes / 60
        let roundedMinute = roundedMinutes % 60

        var newComponents = DateComponents()
        newComponents.year = components.year
        newComponents.month = components.month
        newComponents.day = components.day
        newComponents.hour = roundedHour
        newComponents.minute = roundedMinute

        if let newDate = calendar.date(from: newComponents) {
            return newDate
        } else {
            throw NaturalLanguageFormatterError.invalidRoundedTime(components)
        }
    }
}
