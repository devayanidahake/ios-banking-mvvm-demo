//
//  AccountDTO.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

struct AccountDTO: Decodable, Sendable {

    let id: String
    let accountNumber: String
    let accountName: String
    let balance: Decimal
    let currency: String
}

/**Why DTO?
 
 DTO mirrors the API response.

 It should not contain business logic.

 Why Decodable?

 Allows automatic JSON decoding.

 Why not use Account directly?

 API contracts change frequently.

 Keeping DTOs separate prevents backend changes from affecting the business layer.
 */
