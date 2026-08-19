//
//  SubmissionViewModel.swift
//  SubmissionTriage
//

import Foundation
import Observation

@MainActor
protocol SubmissionViewModelProtocol: AnyObject, Observable {
    var submissions: [Submission] { get }
    var filteredSubmissions: [Submission] { get }
    var searchText: String { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadSubmissions() async
    func isSeen(_ submission: Submission) -> Bool
    func markSeen(_ submission: Submission)
}

@MainActor
@Observable
final class SubmissionViewModel: SubmissionViewModelProtocol {
    private let service: SubmissionServiceProtocol
    private let seenSubmissionsManager: SeenSubmissionsManagerProtocol

    var submissions: [Submission] = []
    var searchText: String = ""
    var isLoading: Bool = true
    var errorMessage: String?
    private var seenIds: Set<Int>

    var filteredSubmissions: [Submission] {
        guard !searchText.isEmpty else { return submissions }
        return submissions.filter {
            ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            ($0.email?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    init(
        service: SubmissionServiceProtocol,
        seenSubmissionsManager: SeenSubmissionsManagerProtocol
    ) {
        self.service = service
        self.seenSubmissionsManager = seenSubmissionsManager
        self.seenIds = seenSubmissionsManager.seenIds()
    }

    func isSeen(_ submission: Submission) -> Bool {
        guard let submissionId = submission.submissionId else { return false }
        return seenIds.contains(submissionId)
    }

    func markSeen(_ submission: Submission) {
        guard let submissionId = submission.submissionId else { return }
        seenSubmissionsManager.markSeen(submissionId)
        seenIds.insert(submissionId)
    }

    func loadSubmissions() async {
        try? await Task.sleep(nanoseconds: 700_000_000)

        isLoading = true
        defer { isLoading = false }

        errorMessage = nil
        do {
            guard Double.random(in: 0...1) > 0.2 else {
                throw SubmissionLoadError.random
            }
            submissions = try service.getSubmissions()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

enum SubmissionLoadError: LocalizedError {
    case random

    var errorDescription: String? {
        "Failed to load submissions. Please try again."
    }
}
