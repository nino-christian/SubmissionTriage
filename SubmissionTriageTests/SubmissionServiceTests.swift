//
//  SubmissionServiceTests.swift
//  SubmissionTriageTests
//

import XCTest
@testable import SubmissionTriage

final class SubmissionServiceTests: XCTestCase {

    private func makeSUT() -> (sut: SubmissionService, mockClient: MockAPIClient) {
        let mockClient = MockAPIClient()
        let sut = SubmissionService(apiClient: mockClient)
        return (sut, mockClient)
    }

    func testGetSubmissions_propagatesClientError() {
        let (sut, mockClient) = makeSUT()
        mockClient.stubbedError = APIClientError.fileNotFound("submissions.json")

        XCTAssertThrowsError(try sut.getSubmissions())
    }

    func testGetSubmissions_returnsSubmissionsFromClient() throws {
        let (sut, mockClient) = makeSUT()
        mockClient.stubbedSubmissions = Submission.stubList

        let result = try sut.getSubmissions()

        XCTAssertEqual(result.count, Submission.stubList.count)
        XCTAssertEqual(mockClient.fetchSubmissionsCallCount, 1)
    }
}
