//
//  NetworkConfiguration.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//
import Foundation

/// Defines the networking configuration used throughout the application.
///
/// This object is immutable and injected into the networking layer,
/// making it easy to switch between Development, QA, Staging,
/// and Production environments.
struct NetworkConfiguration: Sendable {

    /// Base URL of the backend service.
    let baseURL: URL

    /// Default timeout applied to all requests.
    let timeoutInterval: TimeInterval

    /// Default headers added to every request.
    let defaultHeaders: [String: String]

    static let production = NetworkConfiguration(
        baseURL: URL(string: "https://api.bankingapp.com")!,
        timeoutInterval: 30,
        defaultHeaders: [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    )
}

/*Interview Guide
Q1. Why create a NetworkConfiguration object?
Answer

Rather than scattering configuration values (base URL, timeout, headers) across the networking layer, they are centralized in a single immutable configuration object.

Benefits:

Single source of truth
Easier maintenance
Easier testing
Cleaner dependency injection
Q2. Why use a struct instead of an enum with static properties?
Answer

A struct is injectable.

Different configurations can be created for:

Production
QA
Staging
Unit Tests

Example:

let configuration = NetworkConfiguration(
    baseURL: URL(string: "https://localhost")!,
    timeoutInterval: 5,
    defaultHeaders: [:]
)

An enum with static properties behaves like global state and is harder to substitute in tests.

Q3. Why immutable (let)?
Answer

Configuration should never change while the application is running.

Immutable objects:

are thread-safe,
easier to reason about,
and reduce accidental mutations.
Q4. Why inject configuration instead of using global constants?
Answer

Dependency Injection makes dependencies explicit.

Instead of:

RequestBuilder()

we'll later write:

RequestBuilder(configuration: configuration)

This improves testability and follows the Dependency Inversion Principle.

Q5. Which SOLID principles are demonstrated?
Single Responsibility – Holds only networking configuration.
Dependency Inversion – Consumers depend on an injected configuration object rather than global constants.
Q6. Which design patterns are used?
Dependency Injection
Value Object
Configuration Object
⭐ Staff Engineer Review

If I were reviewing this PR, I'd approve it with one comment:

"Good use of an immutable configuration object. Injecting configuration instead of relying on global state makes the networking layer easier to test and evolve. If the application later supports multiple environments or remote configuration, this design can accommodate those changes without modifying consumers."
*/
