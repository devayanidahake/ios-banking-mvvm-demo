//
//  StubEndpoint.swift
//  BankingApp
//
//  Created by Devayani Purandare on 01/07/26.
//

import Foundation
@testable import BankingApp

struct StubEndpoint: Endpoint {

    var path: String = "/accounts"

    var method: HTTPMethod = .get

    var headers: [String : String] = [:]

    var queryItems: [URLQueryItem] = []

    var body: Data? = nil

    var timeoutInterval: TimeInterval = 30

    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
}
