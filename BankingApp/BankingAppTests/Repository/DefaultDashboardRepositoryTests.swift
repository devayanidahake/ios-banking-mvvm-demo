//
//  DefaultDashboardRepositoryTests.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import XCTest
@testable import BankingApp

final class DefaultDashboardRepositoryTests: XCTestCase {

    private var apiClient: MockAPIClient!
    private var sut: DefaultDashboardRepository!

    override func setUp() {
        super.setUp()

        apiClient = MockAPIClient()
        sut = DefaultDashboardRepository(apiClient: apiClient)
    }

    override func tearDown() {
        sut = nil
        apiClient = nil

        super.tearDown()
    }

    func test_fetchAccounts_returnsMappedDomainModels() async throws {

        apiClient.result = [
            AccountDTO(
                id: "1",
                accountNumber: "1234567890",
                accountName: "Savings",
                balance: 1000,
                currency: "INR"
            )
        ]

        let accounts = try await sut.fetchAccounts()

        XCTAssertEqual(accounts.count, 1)
        XCTAssertEqual(accounts.first?.accountName, "Savings")
        XCTAssertEqual(accounts.first?.balance, 1000)
    }

    func test_fetchAccounts_propagatesNetworkError() async {

        apiClient.error = NetworkError.noInternet

        do {

            _ = try await sut.fetchAccounts()

            XCTFail("Expected error")

        } catch {

            XCTAssertEqual(error as? NetworkError, .noInternet)
        }
    }

    func test_fetchAccounts_mapsDTOToDomainCorrectly() async throws {

        apiClient.result = [
            AccountDTO(
                id: "10",
                accountNumber: "9999999999",
                accountName: "Current",
                balance: 5000,
                currency: "USD"
            )
        ]

        let account = try await sut.fetchAccounts().first

        XCTAssertEqual(account?.id, "10")
        XCTAssertEqual(account?.accountNumber, "9999999999")
        XCTAssertEqual(account?.accountName, "Current")
        XCTAssertEqual(account?.balance, 5000)
        XCTAssertEqual(account?.currency, "USD")
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
