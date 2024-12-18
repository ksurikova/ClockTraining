//
//  EnFormatterTests.swift
//  EnFormatterTests
//
//  Created by Kseniia Surikova on 25.11.2024.
//

import XCTest
@testable import ClockTraining

final class EnFormatterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    // test TimeEnFormatters
    func testEnTimeFormatterHalfPastTwo() {

        let timeString = "14:30"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is half past two")
    }

    func testEnTimeFormatterHalfPastEleven() {

        let timeString = "23:30"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is half past eleven")
    }

    func testEnTimeFormatterOneToTwelve() {

        let timeString = "23:59"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is one minute to twelve")
    }

    func testEnTimeFormatterMidnight() {

        let timeString = "00:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is twelve o'clock")
    }

    func testEnTimeFormatterFourSharp() {

        let timeString = "16:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)
        // Then: Assert the expected value
        XCTAssertEqual(result, "It is four o'clock")
    }

    func testEnTimeFormatterQuarterToEight() {

        let timeString = "19:45"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is quarter to eight")
    }

    func testEnTimeFormatterQuarterSixMinutePastThree() {

        let timeString = "03:06"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is six minutes past three")
    }

    func testEnTimeFormatterEightSharp() {

        let timeString = "20:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is eight o'clock")
    }

    func testEnTimeFormatterMidday() {

        let timeString = "12:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: timeString)!

        // When: Calling the greet function
        let result = try? NaturalLanguageEnTimeFormatter().formatWhichCanThrow(date: date)

        // Then: Assert the expected value
        XCTAssertEqual(result, "It is twelve o'clock")
    }
}
