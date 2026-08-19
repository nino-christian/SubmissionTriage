//
//  MockSubmissionViewModel.swift
//  SubmissionTriage
//

import Foundation
import Observation

@Observable
final class MockSubmissionViewModel: SubmissionViewModelProtocol {
    var submissions: [Submission]
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    var filteredSubmissions: [Submission] {
        guard !searchText.isEmpty else { return submissions }
        return submissions.filter {
            ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            ($0.email?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    init(submissions: [Submission] = Submission.stubList) {
        self.submissions = submissions
    }

    func loadSubmissions() {}
}
