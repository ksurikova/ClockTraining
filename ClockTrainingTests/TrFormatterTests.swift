//
//  TrFormatterTests.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 29.11.2024.
//
// Test TimeTRFormatters
import XCTest
@testable import ClockTraining

final class TrFormatterTests: XCTestCase {

    func testTrTimeFormatterHalfPastTwo() {

        let timeString = "14:30"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat iki buçuk")
    }

    func testTrTimeFormatterHalfPastEleven() {

        let timeString = "23:30"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat on bir buçuk")
    }

    func testTrTimeFormatterOneToTwelve() {

        let timeString = "23:59"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat on ikiye bir var")
    }

    func testTrTimeFormatterMidnight() {

        let timeString = "00:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat on iki")
    }

    func testTrTimeFormatterFourSharp() {

        let timeString = "16:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)
        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat dört")
    }

    func testTrTimeFormatterQuarterToEight() {

        let timeString = "19:45"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat sekize çeyrek var")
    }

    func testTrTimeFormatterQuarterSixMinutePastThree() {

        let timeString = "03:06"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat üçü altı geçiyor")
    }

    func testTrTimeFormatterEightSharp() {

        let timeString = "20:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat sekiz")
    }

    func testTrTimeFormatterMidday() {

        let timeString = "12:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageTrTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Saat on iki")
    }
}
