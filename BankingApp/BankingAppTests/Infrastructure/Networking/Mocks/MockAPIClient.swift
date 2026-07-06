//
//  MockAPIClient.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation
@testable import BankingApp

enum MockError: Error {
    case missingStub
}

final class MockAPIClient: APIClient {

    private let accountDTOs: [AccountDTO]
    private let error: Error?

    init(
        accountDTOs: [AccountDTO] = [],
        error: Error? = nil
    ) {
        self.accountDTOs = accountDTOs
        self.error = error
    }

    func request<T: Decodable & Sendable>(
        _ endpoint: Endpoint
    ) async throws -> T {

        if let error {
            throw error
        }

        guard let result = accountDTOs as? T else {
            throw MockError.missingStub
        }

        return result
    }
}
