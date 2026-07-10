//
//  AppContainer.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

final class AppContainer{
    let apiClient: any APIClient
    
    private lazy var dashboardRepository: any DashboardRepository = {
        DefaultDashboardRepository(apiClient: apiClient)
    }()
    
    private lazy var getAccountUseCase: any GetAccountsUseCase = {
       DefaultGetAccountUseCase(repository: dashboardRepository)
    }()
    
    init() {
        let configuration = NetworkConfiguration.production
        let session = URLSession.shared
        
        let requestBuilder = RequestBuilder(configuration: configuration)
        
        let responseValidator = ResponseValidator()
        
        let decoder = JSONDecoderFactory.makeDefaultDecoder()
        
        self.apiClient = URLSessionAPIClient(session: session, requestBuilder: requestBuilder, responseValidator: responseValidator, decoder: decoder)
    }
    
    func  makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(getAccountUseCase: getAccountUseCase)
    }
    
}
