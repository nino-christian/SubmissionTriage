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
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.filteredSubmissions) { submission in
                        SubmissionRowView(submission: submission) {
                            router.push(.submissionDetail(submission))
                        }
                        Divider()
                    }
                }
            }
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

#Preview {
    SubmissionView(viewModel: MockSubmissionViewModel())
}
