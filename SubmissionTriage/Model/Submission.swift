//
//  Submission.swift
//  SubmissionTriage
//

import Foundation

struct Submission: Codable, Identifiable {
    let id: Int?
    let name: String?
    let email: String?
    let phone: String?
    let service: String?
    let status: String?
    let message: String?
    let submittedAt: String?
    let formVersion: String?
    let internalNotes: String?
}
