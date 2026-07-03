//
//  XCTestCase+Async.swift
//  BankingApp
//
//  Created by Devayani Purandare on 03/07/26.
//
import XCTest
@testable import BankingApp

extension XCTestCase {

    /// Verifies that an async operation throws the expected NetworkError.
    func XCTAssertThrowsNetworkError<T>(
        _ expectedError: NetworkError,
        operation: @escaping () async throws -> T,
        file: StaticString = #filePath,
        line: UInt = #line
    ) async {

        do {
            _ = try await operation()
            XCTFail(
                "Expected \(expectedError) to be thrown.",
                file: file,
                line: line
            )
        } catch let error as NetworkError {
            XCTAssertEqual(
                error,
                expectedError,
                file: file,
                line: line
            )
        } catch {
            XCTFail(
                "Expected NetworkError but received \(error).",
                file: file,
                line: line
            )
        }
    }
}
