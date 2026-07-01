
//
//  RequestBBuilder.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//

import Foundation

/// Responsible for converting an Endpoint into a URLRequest.
///
/// This type contains no networking logic.
/// It only builds requests.
struct RequestBuilder {

    private let configuration: NetworkConfiguration

    init(configuration: NetworkConfiguration) {
        self.configuration = configuration
    }

    func build(from endpoint: Endpoint) throws -> URLRequest {

        guard var components = URLComponents(
            url: configuration.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.invalidURL
        }

        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.timeoutInterval = endpoint.timeoutInterval
        request.cachePolicy = endpoint.cachePolicy

        configuration.defaultHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        endpoint.headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}

/*
 Interview Guide
 Q1. Why create RequestBuilder?
 Answer

 RequestBuilder has a single responsibility: transforming an Endpoint into a URLRequest.

 It keeps request creation separate from request execution.

 This follows the Single Responsibility Principle.

 Q2. Why use URLComponents?
 Answer

 URLComponents safely handles:

 URL encoding
 Query parameters
 Special characters
 Unicode

 Manually concatenating strings is error-prone.

 Q3. Why inject NetworkConfiguration?
 Answer

 It avoids global state and makes the builder environment-independent.

 Different configurations (Production, QA, Staging) can be injected without modifying the builder.

 Q4. Why merge default headers and endpoint headers?
 Answer

 Application-wide headers (Accept, Content-Type) are defined once.

 Individual endpoints can override them when necessary.

 This avoids duplication while maintaining flexibility.

 Q5. Which SOLID principles are demonstrated?
 Single Responsibility – Builds URLRequest only.
 Dependency Inversion – Depends on NetworkConfiguration, not global constants.
 Open/Closed – New endpoint types work without modifying the builder.
 Q6. Which Design Patterns are used?
 Builder Pattern – Constructs a complex URLRequest step by step.
 Dependency Injection – Configuration is injected.
 Protocol-Oriented Programming – Operates on the Endpoint abstraction. */
