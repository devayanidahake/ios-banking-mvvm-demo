//
//  ResponseValidatorTests.swift
//  BankingApp
//
//  Created by Devayani Purandare on 01/07/26.


import XCTest
@testable import BankingApp

final class ResponseValidatorTests: XCTestCase {

    // MARK: - Properties

    private let sut = ResponseValidator()


    // MARK: - Success Responses

    func test_validate_given200Response_doesNotThrow() {

        // Arrange

        let response = makeHTTPResponse(statusCode: 200)

        // Act & Assert

        XCTAssertNoThrow(
            try sut.validate(response)
        )
    }

    func test_validate_given299Response_doesNotThrow() {

        // Arrange

        let response = makeHTTPResponse(statusCode: 299)

        // Act & Assert

        XCTAssertNoThrow(
            try sut.validate(response)
        )
    }

    // MARK: - Client Errors

    func test_validate_given300Response_throwsUnexpectedStatusCode() {

        // Arrange

        let response = makeHTTPResponse(statusCode: 300)

        // Act & Assert

        XCTAssertThrowsError(
            try sut.validate(response)
        ) { error in

            guard case .unexpectedStatusCode(let statusCode) = error as? NetworkError else {
                return XCTFail("Expected .unexpectedStatusCode")
            }

            XCTAssertEqual(statusCode, 300)
        }
    }

    func test_validate_given401Response_throwsUnauthorized() {

        // Arrange

        let response = makeHTTPResponse(statusCode: 401)

        // Act & Assert

        XCTAssertThrowsError(
            try sut.validate(response)
        ) { error in

            XCTAssertEqual(
                error as? NetworkError,
                .unauthorized
            )
        }
    }

    func test_validate_given403Response_throwsForbidden() {

        // Arrange

        let response = makeHTTPResponse(statusCode: 403)

        // Act & Assert

        XCTAssertThrowsError(
            try sut.validate(response)
        ) { error in

            XCTAssertEqual(
                error as? NetworkError,
                .forbidden
            )
        }
    }

    func test_validate_given404Response_throwsNotFound() {

        // Arrange

        let response = makeHTTPResponse(statusCode: 404)

        // Act & Assert

        XCTAssertThrowsError(
            try sut.validate(response)
        ) { error in

            XCTAssertEqual(
                error as? NetworkError,
                .notFound
            )
        }
    }

    // MARK: - Server Errors

    func test_validate_given500Response_throwsServerError() {

        // Arrange

        let response = makeHTTPResponse(statusCode: 500)

        // Act & Assert

        XCTAssertThrowsError(
            try sut.validate(response)
        ) { error in

            guard case .serverError(let statusCode) = error as? NetworkError else {
                return XCTFail("Expected .serverError")
            }

            XCTAssertEqual(statusCode, 500)
        }
    }

    // MARK: - Invalid Response

    func test_validate_givenNonHTTPResponse_throwsUnknown() {

        // Arrange

        let response = URLResponse()

        // Act & Assert

        XCTAssertThrowsError(
            try sut.validate(response)
        ) { error in

            XCTAssertEqual(
                error as? NetworkError,
                .unknown
            )
        }
    }
}

// MARK: - Helpers

private extension ResponseValidatorTests {

    func makeHTTPResponse(
        statusCode: Int
    ) -> HTTPURLResponse {

        HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}

/**Interview Notes
 Q. Why one test per status code?

 Answer

 Each test validates exactly one behavior.

 Benefits:

 Easier debugging
 Better failure reporting
 Clear intent
 Easier maintenance

 If 403 mapping breaks, only one test fails.

 Q. Why setUp() instead of creating ResponseValidator() in every test?

 Either approach is valid.

 I chose setUp() because:

 every test uses the validator,
 it removes duplication,
 and mirrors production dependency creation.

 If the object were immutable and only used in one or two tests, creating it inline would also be acceptable.

 Q. Why didn't you test every status code?

answer:

 HTTP responses are grouped by behavior rather than individual values. Instead of testing every status code, I tested the boundaries of each behavior. For example, testing 200 and 299 verifies the entire success range, while 300 verifies the transition into non-success responses. This keeps the test suite concise while providing strong confidence.

 That answer immediately signals senior-level testing experience*/
