//
//  DefaultDashboardRepositoryTests.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import XCTest
@testable import BankingApp

final class DefaultDashboardRepositoryTests: XCTestCase {

    func test_fetchAccounts_returnsMappedDomainModels() async throws {

        let apiClient = MockAPIClient(
            accountDTOs: [
                AccountDTO(
                    id: "1",
                    accountNumber: "1234567890",
                    accountName: "Savings",
                    balance: 1000,
                    currency: "INR"
                )
            ]
        )

        let sut = DefaultDashboardRepository(apiClient: apiClient)

        let accounts = try await sut.fetchAccounts()

        XCTAssertEqual(accounts.count, 1)
        XCTAssertEqual(accounts.first?.id, "1")
        XCTAssertEqual(accounts.first?.accountNumber, "1234567890")
        XCTAssertEqual(accounts.first?.accountName, "Savings")
        XCTAssertEqual(accounts.first?.balance, 1000)
        XCTAssertEqual(accounts.first?.currency, "INR")
    }

    func test_fetchAccounts_propagatesNetworkError() async {

        let apiClient = MockAPIClient(
            error: NetworkError.noInternet
        )

        let sut = DefaultDashboardRepository(apiClient: apiClient)

        do {

            _ = try await sut.fetchAccounts()
            XCTFail("Expected NetworkError.noInternet")

        } catch {

            XCTAssertEqual(error as? NetworkError, .noInternet)
        }
    }

    func test_fetchAccounts_returnsEmptyArray_whenNoAccountsExist() async throws {

        let apiClient = MockAPIClient(
            accountDTOs: []
        )

        let sut = DefaultDashboardRepository(apiClient: apiClient)

        let accounts = try await sut.fetchAccounts()

        XCTAssertTrue(accounts.isEmpty)
    }
}

/**Interview Questions
 Why MockAPIClient?

 Answer

 The repository depends on APIClient, not on HTTPSession.

 Tests should mock the immediate dependency rather than lower-level implementation details.

 Why test mapping?

 The repository's responsibility is not only fetching data but also transforming DTOs into domain models.

 Testing the mapping ensures business models are created correctly.

 Why not mock URLSession?

 Because DefaultDashboardRepository doesn't depend on URLSession.

 Unit tests should isolate the class under test by mocking only its direct collaborators.*/
