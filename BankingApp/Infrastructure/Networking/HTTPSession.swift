//
//  HTTPSession.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.

import Foundation

/// Abstraction over URLSession to improve testability.
///
/// Production uses URLSession.
/// Unit tests inject a mock implementation.
protocol HTTPSession: Sendable {

    func data(
        for request: URLRequest
    ) async throws -> (Data, URLResponse)
}

extension URLSession: HTTPSession {}

/*Interview Guide
Q1. Why create HTTPSession?
Answer

Instead of depending directly on URLSession, the networking layer depends on an abstraction.

Benefits:

Easier unit testing
Dependency Injection
Loose coupling
Better maintainability
Q2. Why not use URLSession.shared?
Answer

URLSession.shared is a global dependency.

Global dependencies make testing difficult because they cannot easily be replaced.

Instead:

APIClient

↓

HTTPSession

↓

URLSession

This follows the Dependency Inversion Principle.

Q3. Why protocol instead of subclassing URLSession?
Answer

URLSession isn't intended for inheritance.

Protocol abstraction:

avoids inheritance
improves mocking
keeps tests simple
Q4. Which SOLID principle is demonstrated?
Dependency Inversion

High-level networking code depends on an abstraction.

Not Foundation.

Q5. Which Design Pattern?

Dependency Injection

Adapter

Protocol-Oriented Programming

Q6. Why Sendable?

Because the networking layer is fully async.

Dependencies crossing concurrency boundaries should conform to Sendable.
 
 Q: Why inject HTTPSession instead of using URLSession.shared?
 Expected Senior Answer

 We are not injecting a new URLSession for every request. We inject the dependency once during application composition. In production, that dependency is a single configured URLSession instance, which is reused for all requests. By depending on the HTTPSession protocol instead of URLSession.shared, the APIClient is decoupled from Foundation, becomes easy to unit test, and follows the Dependency Inversion Principle. During testing, we simply replace the implementation with a mock without changing the APIClient.
*/
