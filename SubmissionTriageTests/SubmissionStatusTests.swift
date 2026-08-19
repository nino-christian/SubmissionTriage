//
//  SubmissionStatusTests.swift
//  SubmissionTriageTests
//

import XCTest
@testable import SubmissionTriage

final class SubmissionStatusTests: XCTestCase {

    func testInitWithNilRawValueReturnsNil() {
        XCTAssertNil(SubmissionStatus(rawValue: nil))
    }

    func testInitWithEmptyRawValueReturnsNil() {
        XCTAssertNil(SubmissionStatus(rawValue: "   "))
    }

    func testInitMapsKnownValues() {
        XCTAssertEqual(SubmissionStatus(rawValue: "new"), .new)
        XCTAssertEqual(SubmissionStatus(rawValue: "open"), .open)
        XCTAssertEqual(SubmissionStatus(rawValue: "pending"), .pending)
        XCTAssertEqual(SubmissionStatus(rawValue: "in review"), .inReview)
        XCTAssertEqual(SubmissionStatus(rawValue: "reviewed"), .reviewed)
        XCTAssertEqual(SubmissionStatus(rawValue: "closed"), .closed)
    }

    func testInitIsCaseInsensitiveAndTrimsWhitespace() {
        XCTAssertEqual(SubmissionStatus(rawValue: "  NEW  "), .new)
        XCTAssertEqual(SubmissionStatus(rawValue: "Closed"), .closed)
    }

    func testInitReplacesUnderscoresWithSpaces() {
        XCTAssertEqual(SubmissionStatus(rawValue: "in_review"), .inReview)
    }

    func testInitWithUnknownValuePreservesOriginalRawValue() {
        XCTAssertEqual(SubmissionStatus(rawValue: "archived"), .unknown("archived"))
        XCTAssertEqual(SubmissionStatus(rawValue: "  Archived  "), .unknown("  Archived  "))
    }
}
