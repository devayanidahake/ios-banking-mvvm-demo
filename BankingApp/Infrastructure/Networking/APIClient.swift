//
//  APIClient.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.

import Foundation

/// Defines the contract for executing HTTP requests.
///
/// APIClient is responsible for executing an Endpoint
/// and decoding the response into the requested model.
/// /// - Important:
/// APIClient should never expose Foundation networking
/// types outside Infrastructure.
/// 
protocol APIClient: Sendable {

    func request<T: Decodable & Sendable>(
        _ endpoint: Endpoint
    ) async throws -> T
}


/**Interview Notes
 Q1. Why protocol instead of class?
 Senior Answer

 The networking layer depends on abstractions rather than implementations.

 This allows different implementations such as:

 URLSessionAPIClient
 MockAPIClient
 PreviewAPIClient

 without changing consumers.

 This follows the Dependency Inversion Principle.

 Q2. Why generic?

 Instead of

 login()

 fetchAccounts()

 fetchTransactions()

 one reusable API supports every endpoint.

 Compile-time type safety.

 Q3. Why Decodable?

 APIClient shouldn't know business models.

 It only knows:

 "I can decode anything."

 Q4. Why Sendable?

 Our networking layer uses Swift Concurrency.

 Decoded models crossing actor/task boundaries should conform to Sendable.

 Future-proof.

 Q5. Why async/await?

 Advantages over completion handlers:

 Linear code flow
 Better error propagation
 Structured concurrency
 Easier cancellation
 Cleaner tests
 Q6. Why doesn't APIClient know URLSession?

 Because execution strategy belongs to the implementation.

 Today

 URLSessionAPIClient

 Tomorrow

 MockAPIClient

 or

 OfflineAPIClient

 without changing callers.

 Q7. Which SOLID principles?

 ✅ Dependency Inversion

 High-level layers depend on APIClient.

 Not URLSession.

 Q8. Which Design Patterns?
 Repository Support
 Dependency Injection
 Strategy Pattern
 Protocol-Oriented Programming*/
