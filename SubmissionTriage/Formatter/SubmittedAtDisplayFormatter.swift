//
//  SubmittedAtDisplayFormatter.swift
//  SubmissionTriage
//

import Foundation

enum SubmittedAtDisplayFormatter {
    private static let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    private static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, MMM d, yyyy"
        return formatter
    }()

    static func string(from parsedDate: ParsedDate?) -> String? {
        guard let parsedDate else { return nil }
        let formatter = parsedDate.hasTimeComponent ? dateTimeFormatter : dateOnlyFormatter
        return formatter.string(from: parsedDate.date)
    }
}
