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
    var hasLoadedOnce: Bool = true
    var errorMessage: String?
    private var seenIds: Set<Int> = []

    var filteredSubmissions: [Submission] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return submissions }
        return submissions.filter {
            ($0.name?.localizedCaseInsensitiveContains(query) ?? false) ||
            ($0.email?.localizedCaseInsensitiveContains(query) ?? false)
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
