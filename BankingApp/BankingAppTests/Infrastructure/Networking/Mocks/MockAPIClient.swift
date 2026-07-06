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

    var result: Any?
    var error: Error?

    private(set) var capturedEndpoint: (any Endpoint)?

    func request<T: Decodable & Sendable>(
        _ endpoint: Endpoint
    ) async throws -> T {

        capturedEndpoint = endpoint

        if let error {
            throw error
        }

        guard let result = result as? T else {
            throw MockError.missingStub
        }

        return result
    }
}
