//
//  RuFormatterTests.swift
//  ClockTraining
//
//  Created by Kseniia Surikova on 29.11.2024.
//
// test TimeRuFormatters
import XCTest
@testable import ClockTraining

final class RuFormatterTests: XCTestCase {

    func testRuTimeFormatterHalfPastTwo() {

        let timeString = "14:30"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас половина третьего")
    }

    func testRuTimeFormatterHalfPastEleven() {

        let timeString = "23:30"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас половина двенадцатого")
    }

    func testRuTimeFormatterOneToTwelve() {

        let timeString = "23:59"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас без одной минуты двенадцать")
    }

    func testRuTimeFormatterMidnight() {

        let timeString = "00:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас двенадцать часов ночи")
    }

    func testRuTimeFormatterFourSharp() {

        let timeString = "16:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)
        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас четыре часа дня")
    }

    func testRuTimeFormatterQuarterToEight() {

        let timeString = "19:45"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас без пятнадцати минут восемь")
    }

    func testRuTimeFormatterQuarterSixMinutePastThree() {

        let timeString = "03:06"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас шесть минут четвертого")
    }

    func testRuTimeFormatterEightSharp() {

        let timeString = "20:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас восемь часов вечера")
    }

    func testRuTimeFormatterMidday() {

        let timeString = "12:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас двенадцать часов дня")
    }

    func testRuTimeFormatterTenEleven() {

        let timeString = "10:11"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас одиннадцать минут одиннадцатого")
    }

    func testRuTimeFormatterNineTwentyTwo() {

        let timeString = "21:22"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас двадцать две минуты десятого")
    }

    func testRuTimeFormatterTwoForty() {

        let timeString = "02:40"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас без двадцати минут три")
    }

    func testRuTimeFormatterTwelveFiftyNine() {

        let timeString = "12:51"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас без девяти минут час")
    }

    func testRuTimeFormatterZeroTwenty() {

        let timeString = "00:20"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас двадцать минут первого")
    }

    func testRuTimeFormatterFiveThirtyNine() {

        let timeString = "05:39"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас без двадцати одной минуты шесть")
    }

    func testRuTimeFormatterOneSharp() {

        let timeString = "01:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageRuTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "Сейчас час ночи")
    }
}
