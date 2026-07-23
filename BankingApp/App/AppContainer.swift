//
//  AppContainer.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

final class AppContainer {

    // MARK: - Configuration

    private let useMockData: Bool

    // MARK: - Core

    private lazy var apiClient: any APIClient = {

        let configuration = NetworkConfiguration.production

        let session = URLSession.shared

        let requestBuilder = RequestBuilder(
            configuration: configuration
        )

        let responseValidator = ResponseValidator()

        let decoder = JSONDecoderFactory.makeDefaultDecoder()

        return URLSessionAPIClient(
            session: session,
            requestBuilder: requestBuilder,
            responseValidator: responseValidator,
            decoder: decoder
        )
    }()

    // MARK: - Repository

    private lazy var dashboardRepository: any DashboardRepository = {

        if useMockData {
            return MockDashboardRepository()
        }

        return DefaultDashboardRepository(
            apiClient: apiClient
        )
    }()

    // MARK: - UseCases

    private lazy var getAccountsUseCase: any GetAccountsUseCase = {

        DefaultGetAccountUseCase(
            repository: dashboardRepository
        )
    }()

    // MARK: - Initializer

    init(useMockData: Bool = true) {
        self.useMockData = useMockData
    }

    // MARK: - Factory

    @MainActor
    func makeDashboardViewModel() -> DashboardViewModel {

        DashboardViewModel(
            getAccountUseCase: getAccountsUseCase
        )
    }
}
