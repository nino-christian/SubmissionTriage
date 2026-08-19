//
//  SubmissionService.swift
//  SubmissionTriage
//

import Foundation

protocol SubmissionServiceProtocol {
    func getSubmissions() throws -> [Submission]
}

struct SubmissionService: SubmissionServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getSubmissions() throws -> [Submission] {
        try apiClient.fetchSubmissions()
    }
}
