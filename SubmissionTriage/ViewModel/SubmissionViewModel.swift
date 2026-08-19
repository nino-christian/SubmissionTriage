//
//  SubmissionViewModel.swift
//  SubmissionTriage
//

import Foundation
import Observation

protocol SubmissionViewModelProtocol: AnyObject, Observable {
    var submissions: [Submission] { get }
    var filteredSubmissions: [Submission] { get }
    var searchText: String { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadSubmissions()
}

@Observable
final class SubmissionViewModel: SubmissionViewModelProtocol {
    private let service: SubmissionServiceProtocol

    var submissions: [Submission] = []
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

    init(service: SubmissionServiceProtocol) {
        self.service = service
    }

    func loadSubmissions() {
        isLoading = true
        errorMessage = nil
        do {
            submissions = try service.getSubmissions()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
