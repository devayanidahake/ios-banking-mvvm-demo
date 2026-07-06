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

