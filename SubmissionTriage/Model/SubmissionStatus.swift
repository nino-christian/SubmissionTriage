//
//  SubmissionStatus.swift
//  SubmissionTriage
//

import Foundation

enum SubmissionStatus: Codable, Equatable {
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
}
