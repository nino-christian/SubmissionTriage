//
//  MockSubmissionViewModel.swift
//  SubmissionTriage
//

import Foundation
import Observation

@MainActor
@Observable
final class MockSubmissionViewModel: SubmissionViewModelProtocol {
    var submissions: [Submission]
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    private var seenIds: Set<Int> = []

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

    func isSeen(_ submission: Submission) -> Bool {
        guard let submissionId = submission.submissionId else { return false }
        return seenIds.contains(submissionId)
    }

    func markSeen(_ submission: Submission) {
        guard let submissionId = submission.submissionId else { return }
        seenIds.insert(submissionId)
    }
}
