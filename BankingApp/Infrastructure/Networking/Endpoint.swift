//
//  Endpoint.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//
import Foundation

/// Describes a single API endpoint.
///
/// An Endpoint contains only request metadata.
/// It does not create URLRequest instances.
/// RequestBuilder is responsible for building URLRequest.
protocol Endpoint {

    /// Relative API path.
    ///
    /// Example:
    /// "/v1/accounts"
    var path: String { get }

    /// HTTP Method
    var method: HTTPMethod { get }

    /// HTTP Headers
    var headers: [String: String] { get }

    /// URL Query Parameters
    var queryItems: [URLQueryItem] { get }

    /// HTTP Body
    var body: Data? { get }

    /// Request timeout
    var timeoutInterval: TimeInterval { get }
}

extension Endpoint {

    var headers: [String: String] {
        [:]
    }

    var queryItems: [URLQueryItem] {
        []
    }

    var body: Data? {
        nil
    }

    var timeoutInterval: TimeInterval {
        30
    }
}
/*✅ Why Endpoint protocol?
 
 ✅ Why default implementations?
 
 ✅ Why not URLRequest?
 
 ✅ Why no baseURL?
 Then RequestBuilder combines:

 baseURL
 +
 path

 This allows:

 Development
 QA
 Staging
 Production

 without touching endpoints.
 
 ✅ Why RequestBuilder?
 var body: Encodable?

 This creates a lot of complexity because protocols with Encodable are awkward to encode generically.

 Instead:

 RequestBuilder will encode DTOs.

 Endpoint only stores the final Data.

 Much cleaner.
 */
