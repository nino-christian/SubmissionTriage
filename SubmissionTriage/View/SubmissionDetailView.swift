//
//  SubmissionDetailView.swift
//  SubmissionTriage
//

import SwiftUI

struct SubmissionDetailView: View {
    let submission: Submission

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(submission.displayName ?? "Unknown")
                        .font(.title2.bold())
                    Text(SubmittedAtDisplayFormatter.string(from: submission.submittedAt) ?? "—")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if let status = submission.status {
                    Text(status.displayText)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(status.color)
                        )
                }

                Divider()

                detailRow(title: "Service", value: submission.service)
                detailRow(title: "Email", value: submission.email)
                detailRow(title: "Phone", value: submission.phone)
                detailRow(title: "Form Version", value: submission.formVersion)
                detailRow(title: "Message", value: submission.message)
                detailRow(title: "Internal Notes", value: submission.internalNotes)
            }
            .padding()
        }
        .navigationTitle("Submission Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func detailRow(title: String, value: String?) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value ?? "—")
                .font(.body)
        }
    }
}

#Preview {
    NavigationStack {
        SubmissionDetailView(submission: .stub)
    }
}
