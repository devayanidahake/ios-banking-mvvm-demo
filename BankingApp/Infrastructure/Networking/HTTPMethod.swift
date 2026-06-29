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
