//
//  Submission.swift
//  SubmissionTriage
//

import Foundation

struct Submission: Codable, Identifiable, Hashable {
    let id = UUID()
    let submissionId: Int?
    let name: String?
    let email: String?
    let phone: String?
    let service: String?
    let status: SubmissionStatus?
    let message: String?
    let submittedAt: ParsedDate?
    let formVersion: String?
    let internalNotes: String?

    var displayName: String? {
        guard let name else { return nil }
        let trimmed = name
            .split(separator: " ", omittingEmptySubsequences: true)
            .joined(separator: " ")
        return trimmed.isEmpty ? nil : trimmed
    }

    enum CodingKeys: String, CodingKey {
        case submissionId = "id"
        case name, email, phone, service, status, message, submittedAt, formVersion, internalNotes
    }

    init(
        id: Int?,
        name: String?,
        email: String?,
        phone: String?,
        service: String?,
        status: SubmissionStatus?,
        message: String?,
        submittedAt: ParsedDate?,
        formVersion: String?,
        internalNotes: String?
    ) {
        self.submissionId = id
        self.name = name
        self.email = email
        self.phone = phone
        self.service = service
        self.status = status
        self.message = message
        self.submittedAt = submittedAt
        self.formVersion = formVersion
        self.internalNotes = internalNotes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let rawIdInt = try? container.decodeIfPresent(Int.self, forKey: .submissionId) {
            submissionId = rawIdInt
        } else if let rawIdString = try? container.decodeIfPresent(String.self, forKey: .submissionId) {
            submissionId = Int(rawIdString)
        } else {
            submissionId = nil
        }
        name = try container.decodeIfPresent(String.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        if let rawPhoneString = try? container.decodeIfPresent(String.self, forKey: .phone) {
            phone = rawPhoneString
        } else if let rawPhoneInt = try? container.decodeIfPresent(Int.self, forKey: .phone) {
            phone = String(rawPhoneInt)
        } else {
            phone = nil
        }
        service = try container.decodeIfPresent(String.self, forKey: .service)
        status = SubmissionStatus(rawValue: try container.decodeIfPresent(String.self, forKey: .status))
        message = try container.decodeIfPresent(String.self, forKey: .message)
        formVersion = try container.decodeIfPresent(String.self, forKey: .formVersion)
        internalNotes = try container.decodeIfPresent(String.self, forKey: .internalNotes)

        if let rawString = try? container.decodeIfPresent(String.self, forKey: .submittedAt) {
            submittedAt = FlexibleDateFormatter.parse(rawString)
        } else if let rawInt = try? container.decodeIfPresent(Int.self, forKey: .submittedAt) {
            submittedAt = FlexibleDateFormatter.parse(String(rawInt))
        } else {
            submittedAt = nil
        }
    }
}
