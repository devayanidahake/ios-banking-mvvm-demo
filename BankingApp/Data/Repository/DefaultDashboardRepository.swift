//
//  DashboardRepositoryImpl.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

final class DefaultDashboardRepository: DashboardRepository {

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
/**Why DefaultDashboardRepository instead of DashboardRepositoryImpl?
 
 Impl is a Java convention.

 Swift favors descriptive names.

 Examples:

 DefaultDashboardRepository
 LiveDashboardRepository
 MockDashboardRepository
 Why inject APIClient?

 Improves testing.

 Allows replacing networking without changing repository code.

 Why Repository Pattern?

 The repository hides where data comes from.

 Today:

 API

 Tomorrow:

 API
 +
 CoreData
 +
 Cache

 The ViewModel doesn't change.

 Why Mapper here?

 Repositories are responsible for converting infrastructure models into business models.

 Why not expose AccountDTO?

 DTO belongs to the data layer.

 Business logic should only work with domain models.*/
