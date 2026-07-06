//
//  Account.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

struct Account: Sendable, Identifiable, Equatable {

    let id: String
    let accountNumber: String
    let accountName: String
    let balance: Decimal
    let currency: String
}

/**Why separate Domain Model from DTO?
 
 Answer

 The domain model represents business data used by the application.

 It should remain independent of how data is received from the backend.

 If the API changes, only the DTO changes while business logic remains unaffected.

 Why Equatable?

 For unit testing and SwiftUI state comparison.

 Why Identifiable?

 Allows SwiftUI lists to uniquely identify each account.

 Why Sendable?

 Ensures thread safety when values cross concurrency boundaries.*/
