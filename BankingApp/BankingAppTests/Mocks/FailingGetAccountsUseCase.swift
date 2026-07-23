//
//  FailingGetAccountsUseCase.swift
//  BankingApp
//
//  Created by Devayani Purandare on 23/07/26.
//
import Foundation
@testable import BankingApp

struct FailingGetAccountsUseCase: GetAccountsUseCase {

    func execute() async throws -> [Account] {
        throw NetworkError.noInternet
    }
}
