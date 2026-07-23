//
//  PreviewGetAccountsUseCase.swift
//  BankingApp
//
//  Created by Devayani Purandare on 10/07/26.
//
import Foundation
final class PreviewGetAccountsUseCase: GetAccountsUseCase {
    func execute() async throws -> [Account] {
        return [Account(id: "0001", accountNumber: "12345", accountName: "Savings Account", balance: 20.00, currency: "$"),
                Account(id: "0002", accountNumber: "67890", accountName: "Mortgage Account", balance: 80.55, currency: "$"),
                Account(id: "0003", accountNumber: "13680", accountName: "Fixed Deposit Account", balance: 60.90, currency: "$")]
    }
}
