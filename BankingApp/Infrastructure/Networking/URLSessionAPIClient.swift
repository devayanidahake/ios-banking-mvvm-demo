//
//  URLSessionAPIClient.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//

import Foundation

final class URLSessionAPIClient: APIClient, Sendable {

    private let session: HTTPSession
    private let requestBuilder: RequestBuilder
    private let responseValidator: ResponseValidator
    private let decoder: JSONDecoder

    init(
        session: HTTPSession,
        requestBuilder: RequestBuilder,
        responseValidator: ResponseValidator,
        decoder: JSONDecoder
    ) {
        self.session = session
        self.requestBuilder = requestBuilder
        self.responseValidator = responseValidator
        self.decoder = decoder
    }

    func request<T: Decodable & Sendable>(
        _ endpoint: Endpoint
    ) async throws -> T {

        let request = try requestBuilder.build(from: endpoint)

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError {

            switch error.code {

            case .notConnectedToInternet:
                throw NetworkError.noInternet

            case .timedOut:
                throw NetworkError.requestTimedOut

            case .cancelled:
                throw NetworkError.cancelled

            default:
                throw NetworkError.unknown
            }

        } catch {

            throw NetworkError.unknown
        }

        try responseValidator.validate(response)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

/**Interview Guide
 Q1. Why inject JSONDecoder instead of JSONDecoderFactory?
 Answer

 The factory's responsibility is object creation.

 The APIClient's responsibility is object usage.

 Injecting the decoder follows the Dependency Inversion Principle and makes the client independent of how decoders are configured.

 Q2. Why map URLError to NetworkError?
 Answer

 Higher layers should never depend on Foundation networking types.

 Instead of exposing URLError, the infrastructure layer translates it into semantic NetworkError values that the rest of the application understands.

 This isolates external framework details.

 Q3. Why doesn't URLSessionAPIClient know Repository?
 Answer

 Repositories belong to the Data layer.

 The APIClient is a reusable infrastructure component responsible only for executing HTTP requests and decoding responses.

 Keeping these responsibilities separate improves reuse and testability.

 Q4. Why decode inside APIClient instead of Repository?
 Answer

 Decoding is part of transport.

 Repositories should work with already decoded DTOs and focus on orchestration, mapping, caching, and business rules.

 This keeps concerns separated.

 Q5. Which SOLID principles are demonstrated?
 Single Responsibility – Executes requests and decodes responses.
 Dependency Inversion – Depends on abstractions (HTTPSession, APIClient).
 Open/Closed – Different session implementations can be introduced without modifying the client.
 Q6. Which Design Patterns?
 Dependency Injection
 Strategy Pattern (HTTPSession)
 Builder Pattern (RequestBuilder)
 Factory Pattern (JSONDecoderFactory, used at composition time)*/
