//
//  SubmissionRowView.swift
//  SubmissionTriage
//

import SwiftUI

struct SubmissionRowView: View {
    let submission: Submission
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(submission.displayName ?? "Unknown")
                        .font(.headline)
                    Spacer()
                    Text(SubmittedAtDisplayFormatter.string(from: submission.submittedAt) ?? "—")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text(submission.service ?? "—")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(submission.status?.displayText ?? "—")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(submission.status?.color ?? .secondary)
                        )
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(.primary)
    }
}

#Preview {
    List(Submission.stubList) { submission in
        SubmissionRowView(submission: submission, onTap: {})
    }
}
