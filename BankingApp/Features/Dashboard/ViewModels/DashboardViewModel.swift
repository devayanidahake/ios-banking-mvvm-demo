//
//  DashboardViewModel.swift
//  BankingApp
//
//  Created by Devayani Purandare on 10/07/26.
//

import Foundation
@MainActor
@Observable
final class DashboardViewModel {
    private(set) var getAccountUseCase: GetAccountsUseCase
    private(set) var state = DashboardState.idle
    private(set) var accounts = [Account]()
    
    init(getAccountUseCase: GetAccountsUseCase){
        self.getAccountUseCase = getAccountUseCase
    }
    
    func load() async -> () {
        guard case state = .idle else {
            return
        }
        state = .loading
        do {
            self.accounts = try await self.getAccountUseCase.execute()
            
            self.state = .loaded
        } catch {
            self.state = .failure(error.localizedDescription)
        }
    }
    
}

/**A good rule is:
 
 Repository → protocol (expected multiple implementations)
 UseCase → protocol (business abstraction)
 Service → protocol (replaceable infrastructure)
 ViewModel → concrete type unless there's a demonstrated need for polymorphism
 */

