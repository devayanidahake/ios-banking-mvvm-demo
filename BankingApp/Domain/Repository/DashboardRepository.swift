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
