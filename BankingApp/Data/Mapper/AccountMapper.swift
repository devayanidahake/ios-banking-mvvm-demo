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

