//
//  RequestBuilderTests.swift
//  BankingApp
//
//  Created by Devayani Purandare on 01/07/26.
//


import XCTest
@testable import BankingApp

final class RequestBuilderTests: XCTestCase {

    // MARK: - Properties

    private var sut: RequestBuilder!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        sut = RequestBuilder(
            configuration: .production
        )
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_build_givenGETEndpoint_createsGETRequest() throws {

        // Arrange

        let endpoint = TestEndpoint()

        // Act

        let request = try sut.build(from: endpoint)

        // Assert

        XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)
        
        XCTAssertEqual(
            request.url?.path,
            "/accounts"
        )
        
        XCTAssertEqual(
            request.url?.host,
            "api.bankingapp.com"
        )
    }

    func test_build_givenPOSTEndpoint_setsHTTPBody() throws {

        // Arrange

        let body = """
        {
            "name":"John"
        }
        """.data(using: .utf8)

        let endpoint = TestEndpoint(
            method: .post,
            body: body
        )

        // Act

        let request = try sut.build(from: endpoint)

        // Assert

        XCTAssertEqual(request.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertEqual(request.httpBody, body)
    }

    func test_build_givenEndpointWithHeaders_mergesHeaders() throws {

        // Arrange

        let endpoint = TestEndpoint(
            headers: [
                "Authorization": "Bearer token"
            ]
        )

        // Act

        let request = try sut.build(from: endpoint)

        // Assert

        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Authorization"),
            "Bearer token"
        )

        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Accept"),
            "application/json"
        )
    }

    func test_build_givenQueryItems_buildsEncodedURL() throws {

        // Arrange

        let endpoint = TestEndpoint(
            queryItems: [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "limit", value: "20")
            ]
        )

        // Act

        let request = try sut.build(from: endpoint)

        // Assert

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.bankingapp.com/accounts?page=1&limit=20"
        )
    }

    func test_build_givenTimeout_setsTimeoutInterval() throws {

        // Arrange

        let endpoint = TestEndpoint(
            timeoutInterval: 10
        )

        // Act

        let request = try sut.build(from: endpoint)

        // Assert

        XCTAssertEqual(request.timeoutInterval, 10)
    }

    func test_build_givenCachePolicy_setsCachePolicy() throws {

        // Arrange

        let endpoint = TestEndpoint(
            cachePolicy: .returnCacheDataElseLoad
        )

        // Act

        let request = try sut.build(from: endpoint)

        // Assert

        XCTAssertEqual(
            request.cachePolicy,
            .returnCacheDataElseLoad
        )
    }
}
