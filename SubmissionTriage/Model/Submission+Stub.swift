//
//  Submission+Stub.swift
//  SubmissionTriage
//

import Foundation

extension Submission {
    static let stub = Submission(
        id: 1,
        name: "Maria Santos",
        email: "maria.santos@example.com",
        phone: "+639171234567",
        service: "Web Development",
        status: .new,
        message: "We need a marketing site refresh before Q3.",
        submittedAt: FlexibleDateFormatter.parse("2024-11-03T14:22:00Z"),
        formVersion: "v3",
        internalNotes: nil
    )

    static let stubMinimal = Submission(
        id: 12,
        name: nil,
        email: nil,
        phone: nil,
        service: nil,
        status: nil,
        message: nil,
        submittedAt: nil,
        formVersion: nil,
        internalNotes: nil
    )

    static let stubList: [Submission] = [
        stub,
        Submission(
            id: 2,
            name: "  Liza   Reyes ",
            email: "LIZA.REYES@EXAMPLE.COM",
            phone: "0917 123 4567",
            service: "mobile",
            status: .open,
            message: "iOS app for our delivery riders. Android maybe later.",
            submittedAt: FlexibleDateFormatter.parse("2024/10/28"),
            formVersion: "v2",
            internalNotes: nil
        ),
        Submission(
            id: 15,
            name: "Bianca Flores",
            email: "bianca.flores@example.com",
            phone: "0917-555-7788",
            service: "Mobile App Development",
            status: .pending,
            message: "Healthcare appointment app. Privacy is important to us.",
            submittedAt: FlexibleDateFormatter.parse("2024-11-05T13:30:00Z"),
            formVersion: "v3",
            internalNotes: nil
        ),
        stubMinimal
    ]
}
