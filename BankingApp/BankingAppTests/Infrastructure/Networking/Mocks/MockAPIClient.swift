//
//  MockAPIClient.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation
@testable import BankingApp

final class MockAPIClient: APIClient {

    var result: Any?

    var error: Error?

    func request<T: Decodable & Sendable>(
        _ endpoint: Endpoint
    ) async throws -> T {

        if let error {
            throw error
        }

        guard let result = result as? T else {
            fatalError("Mock result not configured for \(T.self)")
        }

        return result
    }
}
