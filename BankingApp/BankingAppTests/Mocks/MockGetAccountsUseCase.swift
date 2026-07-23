//
//  MockGetAccountsUseCase.swift
//  BankingApp
//
//  Created by Devayani Purandare on 23/07/26.
//
import Foundation
@testable import BankingApp

struct MockGetAccountsUseCase: GetAccountsUseCase {

    func execute() async throws -> [Account] {

        [
            Account(
                id: "1",
                accountNumber: "1234567890",
                accountName: "Savings Account",
                balance: 25000,
                currency: "INR"
            ),
            Account(
                id: "2",
                accountNumber: "9876543210",
                accountName: "Current Account",
                balance: 50000,
                currency: "INR"
            ),
            Account(
                id: "3",
                accountNumber: "4567891230",
                accountName: "Salary Account",
                balance: 100000,
                currency: "INR"
            )
        ]
    }
}
