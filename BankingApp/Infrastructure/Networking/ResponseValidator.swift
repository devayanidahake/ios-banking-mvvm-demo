//
//  ResponseValidator.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//

import Foundation

/// Validates HTTP responses returned by the networking layer.
///
/// Converts HTTP status codes into domain-specific NetworkError values.
struct ResponseValidator {

    func validate(_ response: URLResponse) throws {

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        switch httpResponse.statusCode {

        case 200...299:
            return

        case 401:
            throw NetworkError.unauthorized

        case 403:
            throw NetworkError.forbidden

        case 404:
            throw NetworkError.notFound

        case 500...599:
            throw NetworkError.serverError(
                statusCode: httpResponse.statusCode
            )

        default:
            throw NetworkError.unexpectedStatusCode(
                httpResponse.statusCode
            )
        }
    }
}

/**Interview Guide
 Q1. Why create a separate ResponseValidator?
 Answer

 Separating response validation from request execution follows the Single Responsibility Principle.

 Instead of APIClient handling both networking and HTTP status validation, ResponseValidator focuses only on translating HTTP responses into domain-specific errors.

 Benefits:

 Easier testing
 Cleaner APIClient
 Reusable validation logic
 Q2. Why throw instead of returning Bool?
 Answer

 Validation has only two outcomes:

 Response is valid
 Response is invalid

 Throwing an error immediately exits the execution flow and preserves the reason for failure.

 Returning Bool loses valuable error context.

 Q3. Why treat 200–299 as success?
 Answer

 HTTP defines the entire 2xx range as successful responses.

 Examples:

 200 OK
 201 Created
 202 Accepted
 204 No Content

 Checking only 200 would incorrectly reject valid responses.

 Q4. Why convert HTTP status codes into NetworkError?
 Answer

 The rest of the application shouldn't depend on raw HTTP status codes.

 Instead of checking:

 if response.statusCode == 401

 the app handles:

 NetworkError.unauthorized

 This creates a cleaner and more expressive API.

 Q5. Which SOLID principles are demonstrated?
 Single Responsibility

 Only validates responses.

 Open/Closed

 New status codes can be supported without changing APIClient.

 Q6. Which design pattern is demonstrated?

 This is an example of the Strategy Pattern.

 Different validation strategies could be introduced in the future (REST, GraphQL, gRPC), while APIClient remains unchanged.

 Staff Engineer Review
 ⭐ Approved

 One recommendation I'd leave in a real PR:

 If the backend later returns structured error payloads (for example, validation messages or business error codes), keep ResponseValidator responsible only for HTTP status validation. Introduce a separate ErrorResponseDecoder to decode server-specific error bodies. This preserves single responsibility and keeps the networking pipeline modular.*/
