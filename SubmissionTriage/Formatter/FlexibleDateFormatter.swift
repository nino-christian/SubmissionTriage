//
//  FlexibleDateFormatter.swift
//  SubmissionTriage
//

import Foundation

struct ParsedDate: Codable, Hashable {
    let date: Date
    let hasTimeComponent: Bool
}

enum FlexibleDateFormatter {
    private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    private static let dateTimeFormats = [
        "yyyy-MM-dd HH:mm:ss",
        "yyyy/MM/dd HH:mm:ss"
    ]

    private static let dateOnlyFormats = [
        "yyyy-MM-dd",
        "yyyy/MM/dd",
        "MM-dd-yyyy",
        "MMM d, yyyy"
    ]

    private static let dateTimeFormatters: [DateFormatter] = dateTimeFormats.map { format in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = format
        return formatter
    }

    private static let dateOnlyFormatters: [DateFormatter] = dateOnlyFormats.map { format in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = format
        return formatter
    }

    static func parse(_ rawValue: String?) -> ParsedDate? {
        guard let rawValue else { return nil }
        let trimmed = rawValue.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return nil }

        if let isoDate = iso8601Formatter.date(from: trimmed) {
            return ParsedDate(date: isoDate, hasTimeComponent: true)
        }

        if let epochSeconds = TimeInterval(trimmed) {
            return ParsedDate(date: Date(timeIntervalSince1970: epochSeconds), hasTimeComponent: true)
        }

        for formatter in dateTimeFormatters {
            if let date = formatter.date(from: trimmed) {
                return ParsedDate(date: date, hasTimeComponent: true)
            }
        }

        for formatter in dateOnlyFormatters {
            if let date = formatter.date(from: trimmed) {
                return ParsedDate(date: date, hasTimeComponent: false)
            }
        }

        return nil
    }
}
