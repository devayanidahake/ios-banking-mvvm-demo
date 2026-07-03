//
//  StubEndpoint.swift
//  BankingApp
//
//  Created by Devayani Purandare on 01/07/26.
//

import Foundation
@testable import BankingApp
/// A configurable Endpoint implementation used to create test scenarios.

struct TestEndpoint: Endpoint {

    var path: String = "/accounts"

    var method: HTTPMethod = .get

    var headers: [String : String] = [:]

    var queryItems: [URLQueryItem] = []

    var body: Data? = nil

    var timeoutInterval: TimeInterval = 30

    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
}
