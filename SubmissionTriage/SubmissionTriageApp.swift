//
//  SubmissionTriageApp.swift
//  SubmissionTriage
//
//  Created by Niño Christian on 8/19/26.
//

import SwiftUI

@main
struct SubmissionTriageApp: App {
    private let apiClient: APIClient
    private let submissionService: SubmissionService
    private let seenSubmissionsManager: SeenSubmissionsManager
    private let submissionViewModel: SubmissionViewModel

    init() {
        apiClient = APIClient()
        submissionService = SubmissionService(apiClient: apiClient)
        seenSubmissionsManager = SeenSubmissionsManager()
        submissionViewModel = SubmissionViewModel(
            service: submissionService,
            seenSubmissionsManager: seenSubmissionsManager
        )
    }

    var body: some Scene {
        WindowGroup {
            SubmissionView(viewModel: submissionViewModel)
        }
    }
}
