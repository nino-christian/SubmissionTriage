//
//  MockSubmissionService.swift
//  SubmissionTriageTests
//

import Foundation
@testable import SubmissionTriage

final class MockSubmissionService: SubmissionServiceProtocol {
    var stubbedSubmissions: [Submission] = []
    var stubbedError: Error?
    private(set) var getSubmissionsCallCount = 0

    func getSubmissions() throws -> [Submission] {
        getSubmissionsCallCount += 1
        if let stubbedError {
            throw stubbedError
        }
        return stubbedSubmissions
    }
}
