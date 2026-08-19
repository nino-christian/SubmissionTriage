//
//  MockSeenSubmissionsManager.swift
//  SubmissionTriageTests
//

import Foundation
@testable import SubmissionTriage

final class MockSeenSubmissionsManager: SeenSubmissionsManagerProtocol {
    private var ids: Set<Int> = []

    func seenIds() -> Set<Int> {
        ids
    }

    func markSeen(_ id: Int) {
        ids.insert(id)
    }
}
