//
//  SubmissionView.swift
//  SubmissionTriage
//
//  Created by Niño Christian on 8/19/26.
//

import SwiftUI

struct SubmissionView<ViewModel: SubmissionViewModelProtocol>: View {
    @Bindable private var viewModel: ViewModel
    @State private var router = Router()

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .searchable(text: $viewModel.searchText)
                .navigationTitle("Submission")
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .submissionDetail(let submission):
                        SubmissionDetailView(submission: submission)
                    }
                }
        }
        .environment(router)
        .task {
            await viewModel.loadSubmissions()
        }
    }
}

extension SubmissionView {
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.submissions.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.opacity)
        } else {
            ScrollView {
                stateBody
                    .frame(maxWidth: .infinity)
                    .animation(.default, value: viewModel.errorMessage)
                    .animation(.default, value: viewModel.filteredSubmissions)
                    .transition(.opacity)
            }
            .refreshable {
                await viewModel.loadSubmissions()
            }
        }
    }

    @ViewBuilder
    private var stateBody: some View {
        if let errorMessage = viewModel.errorMessage {
            ContentUnavailableView(
                "Something Went Wrong",
                systemImage: "exclamationmark.triangle",
                description: Text(errorMessage)
            )
            .frame(minHeight: 400)
        } else if viewModel.filteredSubmissions.isEmpty {
            if viewModel.searchText.isEmpty {
                ContentUnavailableView(
                    "No Submissions",
                    systemImage: "tray",
                    description: Text("Submissions will appear here once received.")
                )
                .frame(minHeight: 400)
            } else {
                ContentUnavailableView.search(text: viewModel.searchText)
                    .frame(minHeight: 400)
            }
        } else {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredSubmissions) { submission in
                    SubmissionRowView(submission: submission) {
                        router.push(.submissionDetail(submission))
                    }
                    Divider()
                }
            }
        }
    }
}

#Preview {
    SubmissionView(viewModel: MockSubmissionViewModel())
}
