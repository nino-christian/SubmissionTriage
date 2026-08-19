//
//  SeenSubmissionsManager.swift
//  SubmissionTriage
//

import Foundation

protocol SeenSubmissionsManagerProtocol {
    func seenIds() -> Set<Int>
    func markSeen(_ id: Int)
}

final class SeenSubmissionsManager: SeenSubmissionsManagerProtocol {
    private let defaults: UserDefaults
    private let key = "seenSubmissionIds"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func seenIds() -> Set<Int> {
        Set(defaults.array(forKey: key) as? [Int] ?? [])
    }

    func markSeen(_ id: Int) {
        var ids = seenIds()
        guard ids.insert(id).inserted else { return }
        defaults.set(Array(ids), forKey: key)
    }
}
