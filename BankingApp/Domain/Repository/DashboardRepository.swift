//
//  DashboardRepository.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

protocol DashboardRepository: Sendable {

    func fetchAccounts() async throws -> [Account]
}

/**Why protocol?
 
 High-level modules depend on abstractions.

 ViewModels shouldn't know implementation details.

 Why async throws?

 Fetching data is asynchronous and can fail.

 The API clearly communicates both.

 Why return [Account]?

 Repositories expose domain models, never DTOs.*/
