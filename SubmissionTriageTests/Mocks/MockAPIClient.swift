//
//  MockAPIClient.swift
//  SubmissionTriageTests
//

import Foundation
@testable import SubmissionTriage

final class MockAPIClient: APIClientProtocol {
    var stubbedSubmissions: [Submission] = []
    var stubbedError: Error?
    private(set) var fetchSubmissionsCallCount = 0

    func fetchSubmissions() throws -> [Submission] {
        fetchSubmissionsCallCount += 1
        if let stubbedError {
            throw stubbedError
        }
        return stubbedSubmissions
    }
}
