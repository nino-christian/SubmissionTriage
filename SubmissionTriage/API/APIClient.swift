//
//  APIClient.swift
//  SubmissionTriage
//

import Foundation

enum APIClientError: Error {
    case fileNotFound(String)
}

struct APIClient {
    func fetchSubmissions() throws -> [Submission] {
        guard let url = Bundle.main.url(forResource: "submissions", withExtension: "json") else {
            throw APIClientError.fileNotFound("submissions.json")
        }
        let data = try Data(contentsOf: url)
        return try decodeModel(data)
    }

    private func decodeModel<T: Decodable>(_ data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
