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
                        SubmissionDetailView(
                            submission: submission,
                            isSeen: { viewModel.isSeen(submission) },
                            markSeen: { viewModel.markSeen(submission) }
                        )
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
    private enum DisplayState: Equatable {
        case error(String)
        case empty
        case noResults
        case list
    }

    private var displayState: DisplayState {
        if let errorMessage = viewModel.errorMessage {
            return .error(errorMessage)
        } else if viewModel.filteredSubmissions.isEmpty {
            let isSearching = !viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isSearching ? .noResults : .empty
        } else {
            return .list
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && !viewModel.hasLoadedOnce {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.opacity)
        } else {
            ScrollView {
                stateBody
                    .frame(maxWidth: .infinity)
                    .animation(.default, value: displayState)
                    .transition(.opacity)
            }
            .refreshable {
                await viewModel.loadSubmissions()
            }
        }
    }

    @ViewBuilder
    private var stateBody: some View {
        switch displayState {
        case .error(let errorMessage):
            ContentUnavailableView(
                "Something Went Wrong",
                systemImage: "exclamationmark.triangle",
                description: Text(errorMessage)
            )
            .frame(minHeight: 400)
        case .empty:
            ContentUnavailableView(
                "No Submissions",
                systemImage: "tray",
                description: Text("Submissions will appear here once received.")
            )
            .frame(minHeight: 400)
        case .noResults:
            ContentUnavailableView.search(text: viewModel.searchText)
                .frame(minHeight: 400)
        case .list:
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredSubmissions) { submission in
                    SubmissionRowView(submission: submission, isSeen: viewModel.isSeen(submission)) {
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
