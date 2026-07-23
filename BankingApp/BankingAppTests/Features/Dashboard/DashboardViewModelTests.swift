//
//  DashboardViewModelTests.swift
//  BankingApp
//
//  Created by Devayani Purandare on 23/07/26.
//
import XCTest
@testable import BankingApp

@MainActor
final class DashboardViewModelTests: XCTestCase {

    func test_load_setsLoadedState_andPopulatesAccounts() async {

        let sut = DashboardViewModel(
            getAccountUseCase: MockGetAccountsUseCase()
        )

        await sut.load()

        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.accounts.count, 3)
        XCTAssertEqual(sut.accounts.first?.accountName, "Savings Account")
    }

    func test_load_setsFailureState_whenUseCaseThrows() async {

        let sut = DashboardViewModel(
            getAccountUseCase: FailingGetAccountsUseCase()
        )

        await sut.load()

        guard case .failure = sut.state else {
            XCTFail("Expected failure state")
            return
        }
    }

    func test_load_doesNotReload_whenAlreadyLoaded() async {

        let sut = DashboardViewModel(
            getAccountUseCase: MockGetAccountsUseCase()
        )

        await sut.load()

        let firstAccounts = sut.accounts

        await sut.load()

        XCTAssertEqual(sut.accounts, firstAccounts)
        XCTAssertEqual(sut.state, .loaded)
    }
}
