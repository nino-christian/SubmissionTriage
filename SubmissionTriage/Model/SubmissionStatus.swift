//
//  SubmissionStatus.swift
//  SubmissionTriage
//

import SwiftUI

enum SubmissionStatus: Codable, Hashable {
    case new
    case open
    case pending
    case inReview
    case reviewed
    case closed
    case unknown(String)

    init?(rawValue: String?) {
        guard let rawValue else { return nil }
        let normalized = rawValue
            .trimmingCharacters(in: .whitespaces)
            .lowercased()
            .replacingOccurrences(of: "_", with: " ")
        guard !normalized.isEmpty else { return nil }

        switch normalized {
        case "new": self = .new
        case "open": self = .open
        case "pending": self = .pending
        case "in review": self = .inReview
        case "reviewed": self = .reviewed
        case "closed": self = .closed
        default: self = .unknown(rawValue)
        }
    }

    var displayText: String {
        switch self {
        case .new: "New"
        case .open: "Open"
        case .pending: "Pending"
        case .inReview: "In Review"
        case .reviewed: "Reviewed"
        case .closed: "Closed"
        case .unknown(let raw): raw.capitalized
        }
    }

    var color: Color {
        switch self {
        case .new: .blue
        case .open: .green
        case .pending: .orange
        case .inReview: .purple
        case .reviewed: .teal
        case .closed: .gray
        case .unknown: .secondary
        }
    }
}
