//
//  GetAccountsUseCase.swift
//  BankingApp
//
//  Created by Devayani Purandare on 10/07/26.
//
import Foundation

protocol GetAccountsUseCase {
    func execute() async throws -> [Account]
}

final class DefaultGetAccountUseCase : GetAccountsUseCase, Sendable {
    private let repository: any DashboardRepository
    
    init(repository: any DashboardRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Account] {
        try await repository.fetchAccounts()
    }
}
