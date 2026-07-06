//
//  AccountMapper.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

enum AccountMapper {

    static func toDomain(
        from dto: AccountDTO
    ) -> Account {

        Account(
            id: dto.id,
            accountNumber: dto.accountNumber,
            accountName: dto.accountName,
            balance: dto.balance,
            currency: dto.currency
        )
    }
}

/**Why Mapper?
 
 Separates transformation logic from both DTO and Domain Model.

 Responsibilities:

 Convert API models
 Handle formatting
 Handle default values
 Convert nested structures
 Why not extension AccountDTO?

 Keeping mapping external avoids coupling DTOs to business models.*/
