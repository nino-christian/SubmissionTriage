//
//  SubmissionViewModelTests.swift
//  SubmissionTriageTests
//

import XCTest
@testable import SubmissionTriage

final class SubmissionViewModelTests: XCTestCase {

    private func makeSUT() -> (sut: SubmissionViewModel, mockService: MockSubmissionService) {
        let mockService = MockSubmissionService()
        let sut = SubmissionViewModel(service: mockService)
        return (sut, mockService)
    }

    func testLoadSubmissions_whenServiceThrows_setsErrorMessage() {
        let (sut, mockService) = makeSUT()
        mockService.stubbedError = APIClientError.fileNotFound("submissions.json")

        sut.loadSubmissions()

        XCTAssertNotNil(sut.errorMessage)
        XCTAssertTrue(sut.submissions.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }

    func testLoadSubmissions_whenServiceSucceeds_setsSubmissions() {
        let (sut, mockService) = makeSUT()
        mockService.stubbedSubmissions = Submission.stubList

        sut.loadSubmissions()

        XCTAssertEqual(sut.submissions.count, Submission.stubList.count)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }
}
