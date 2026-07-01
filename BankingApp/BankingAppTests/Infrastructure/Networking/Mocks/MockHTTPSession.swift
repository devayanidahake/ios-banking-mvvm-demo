//
//  MockHTTPSession.swift
//  BankingAppTests
//
//  Created by Devayani Purandare on 01/07/26.

import Foundation
@testable import BankingApp

actor MockHTTPSession: HTTPSession {

    private var result: Result<(Data, URLResponse), Error> =
        .failure(NetworkError.unknown)

    private(set) var lastRequest: URLRequest?

    func setResult(_ result: Result<(Data, URLResponse), Error>) {
        self.result = result
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        lastRequest = request
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

 Test Double (Mock)
 
 Q5. Whenever a protocol conforms to Sendable, we'll ask:

 "Should the implementation be a struct, final class, or actor?"

 We'll choose the type intentionally:

 struct → Immutable value objects (RequestBuilder, NetworkConfiguration)
 final class → Reference types with managed lifecycle (URLSessionAPIClient)
 actor → Mutable shared state accessed concurrently (MockHTTPSession in tests, future caches if needed)*/
