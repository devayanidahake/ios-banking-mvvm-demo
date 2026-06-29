//
//  HTTPMethod.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//

import Foundation

/// Represents an HTTP request method as defined by RFC 9110.
///
/// Using a dedicated type instead of raw strings improves:
/// - Type safety
/// - Readability
/// - Discoverability
/// - Testability
///
/// Example:
///
/// let endpoint = LoginEndpoint(method: .post)
///
public enum HTTPMethod: String, Sendable {

    case get     = "GET"

    case post    = "POST"

    case put     = "PUT"

    case patch   = "PATCH"

    case delete  = "DELETE"

    case head    = "HEAD"

    case options = "OPTIONS"
}


//Why Sendable?
//Answer:
//
//Our networking layer uses Swift Concurrency.
//
//Objects crossing actor/task boundaries should conform to Sendable.
//
//This is modern Swift.
//
//Why String Raw Value?
//
//Because later
//
//request.httpMethod = endpoint.method.rawValue
//
//No switch statement required.
//
//Why not Struct?
//
//Enums guarantee only valid HTTP methods.
//
//Why public?
//
//Although it's an app target today, I want the code to be module-ready.
//
//If later you extract Networking into a Swift Package, no changes are required.
//
//This demonstrates forward-thinking architecture.
