//
//  DashboardRepositoryImpl.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

final class DashboardRepositoryImpl: DashboardRepository {

    private let apiClient: any APIClient

    init(apiClient: any APIClient) {
        self.apiClient = apiClient
    }

    func fetchAccounts() async throws -> [Account] {

        let endpoint = DashboardEndpoint()

        let response: [AccountDTO] = try await apiClient.request(endpoint)

        return response.map(AccountMapper.toDomain)
    }
}
