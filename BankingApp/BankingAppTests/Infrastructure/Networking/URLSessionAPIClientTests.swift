//
//  URLSessionAPIClientTests.swift
//  BankingApp
//
//  Created by Devayani Purandare on 03/07/26.
//

import XCTest
@testable import BankingApp

final class URLSessionAPIClientTests: XCTestCase {

    // MARK: - Properties

    private var session: MockHTTPSession!
    private var sut: URLSessionAPIClient!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        session = MockHTTPSession()

        sut = URLSessionAPIClient(
            session: session,
            requestBuilder: RequestBuilder(configuration: .production),
            responseValidator: ResponseValidator(),
            decoder: JSONDecoderFactory.makeDefaultDecoder()
        )
    }

    override func tearDown() {
        session = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Success

    func test_request_givenSuccessfulResponse_returnsDecodedModel() async throws {

        // Arrange

        let account = AccountDTO(
            id: "12345",
            accountName: "Savings Account"
        )

        let data = try JSONEncoder().encode(account)

        let response = makeHTTPResponse(statusCode: 200)

        await session.setResult(.success((data, response)))

        // Act

        let result: AccountDTO = try await sut.request(TestEndpoint())

        // Assert

        XCTAssertEqual(result, account)
    }

    // MARK: - Transport Errors

    func test_request_givenNoInternet_throwsNoInternet() async {

        // Arrange

        await session.setResult(
            .failure(
                URLError(.notConnectedToInternet)
            )
        )

        // Act & Assert

        await XCTAssertThrowsNetworkError(.noInternet) {

            let _: AccountDTO = try await self.sut.request(TestEndpoint())
        }
    }

    func test_request_givenTimeout_throwsRequestTimedOut() async {

        // Arrange

        await session.setResult(
            .failure(
                URLError(.timedOut)
            )
        )

        // Act & Assert

        await XCTAssertThrowsNetworkError(.requestTimedOut) {

            let _: AccountDTO = try await self.sut.request(TestEndpoint())
        }
    }

    func test_request_givenCancelled_throwsCancelled() async {

        // Arrange

        await session.setResult(
            .failure(
                URLError(.cancelled)
            )
        )

        // Act & Assert

        await XCTAssertThrowsNetworkError(.cancelled) {

            let _: AccountDTO = try await self.sut.request(TestEndpoint())
        }
    }

    func test_request_givenUnknownURLError_throwsUnknown() async {

        // Arrange

        await session.setResult(
            .failure(
                URLError(.badServerResponse)
            )
        )

        // Act & Assert

        await XCTAssertThrowsNetworkError(.unknown) {

            let _: AccountDTO = try await self.sut.request(TestEndpoint())
        }
    }

    // MARK: - Response Validation

    func test_request_givenUnauthorizedResponse_throwsUnauthorized() async {

        // Arrange

        let response = makeHTTPResponse(statusCode: 401)

        await session.setResult(
            .success((Data(), response))
        )

        // Act & Assert

        await XCTAssertThrowsNetworkError(.unauthorized) {

            let _: AccountDTO = try await self.sut.request(TestEndpoint())
        }
    }

    // MARK: - Decoding

    func test_request_givenInvalidJSON_throwsDecodingFailed() async {

        // Arrange

        let response = makeHTTPResponse(statusCode: 200)

        let invalidJSON = Data("Invalid JSON".utf8)

        await session.setResult(
            .success((invalidJSON, response))
        )

        // Act & Assert

        await XCTAssertThrowsNetworkError(.decodingFailed) {

            let _: AccountDTO = try await self.sut.request(TestEndpoint())
        }
    }
}

// MARK: - Helpers

private extension URLSessionAPIClientTests {

    func makeHTTPResponse(
        statusCode: Int
    ) -> HTTPURLResponse {

        HTTPURLResponse(
            url: URL(string: "https://api.bankingapp.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}

// MARK: - Test Models

private struct AccountDTO: Codable, Sendable, Equatable {

    let id: String
    let accountName: String
}
