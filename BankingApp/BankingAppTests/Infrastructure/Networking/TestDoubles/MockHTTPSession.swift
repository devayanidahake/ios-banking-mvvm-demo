//
//  MockHTTPSession.swift
//  BankingAppTests
//
//  Created by Devayani Purandare on 01/07/26.

import Foundation
@testable import BankingApp

final class MockHTTPSession: HTTPSession {

    // MARK: - Properties

    var result: Result<(Data, URLResponse), Error>!

    private(set) var receivedRequest: URLRequest?

    // MARK: - HTTPSession

    func data(
        for request: URLRequest
    ) async throws -> (Data, URLResponse) {

        receivedRequest = request

        return try result.get()
    }
}

/**Interview Notes
 Q1. Why create MockHTTPSession?
 Answer

 The networking layer depends on the HTTPSession protocol rather than URLSession.

 This allows tests to inject a mock implementation, avoiding real network calls.

 Benefits:

 Fast tests
 Deterministic results
 No internet dependency
 Easy simulation of failures
 Q2. Why use Result?
 Answer

 Result naturally represents either:

 Success
 Failure

 It keeps the mock simple while allowing tests to configure different outcomes.

 Q3. Why capture receivedRequest?
 Answer

 Tests often need to verify that the correct request was created.

 Examples:

 HTTP Method
 URL
 Headers
 Body

 Recording the request allows these assertions.

 Q4. Which design pattern?

 Test Double (Mock) */
