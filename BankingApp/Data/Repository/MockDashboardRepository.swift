//
//  MockDashboardRepository.swift
//  BankingApp
//
//  Created by Devayani Purandare on 23/07/26.
//
import Foundation
// TODO: Replace with DefaultDashboardRepository when backend integration is available.
final class MockDashboardRepository: DashboardRepository {

    func fetchAccounts() async throws -> [Account] {

        return [
            Account(
                id: "1",
                accountNumber: "1234567890",
                accountName: "Savings Account",
                balance: 25000.50,
                currency: "INR"
            ),
            Account(
                id: "2",
                accountNumber: "9876543210",
                accountName: "Current Account",
                balance: 85000.00,
                currency: "INR"
            ),
            Account(
                id: "3",
                accountNumber: "4567891230",
                accountName: "Salary Account",
                balance: 154230.75,
                currency: "INR"
            )
        ]
    }
}
