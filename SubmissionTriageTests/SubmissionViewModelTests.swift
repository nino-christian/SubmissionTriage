//
//  SubmissionViewModelTests.swift
//  SubmissionTriageTests
//

import XCTest
@testable import SubmissionTriage

@MainActor
final class SubmissionViewModelTests: XCTestCase {

    private func makeSUT() -> (sut: SubmissionViewModel, mockService: MockSubmissionService) {
        let mockService = MockSubmissionService()
        let seenManager = MockSeenSubmissionsManager()
        let sut = SubmissionViewModel(
            service: mockService,
            seenSubmissionsManager: seenManager
        )
        return (sut, mockService)
    }

    func testLoadSubmissions_whenServiceThrows_setsErrorMessage() async {
        let (sut, mockService) = makeSUT()
        mockService.stubbedError = APIClientError.fileNotFound("submissions.json")

        await sut.loadSubmissions()

        XCTAssertNotNil(sut.errorMessage)
        XCTAssertTrue(sut.submissions.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }

    func testLoadSubmissions_whenServiceSucceeds_setsSubmissions() async {
        let (sut, mockService) = makeSUT()
        mockService.stubbedSubmissions = Submission.stubList

        await sut.loadSubmissions()

        XCTAssertEqual(sut.submissions.count, Submission.stubList.count)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }
}
