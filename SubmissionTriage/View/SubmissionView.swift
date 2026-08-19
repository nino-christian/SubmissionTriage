//
//  SubmissionView.swift
//  SubmissionTriage
//
//  Created by Niño Christian on 8/19/26.
//

import SwiftUI

struct SubmissionView<ViewModel: SubmissionViewModelProtocol>: View {
    @Bindable private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await viewModel.loadSubmissions()
        }
    }
}

#Preview {
    SubmissionView(viewModel: MockSubmissionViewModel())
}
