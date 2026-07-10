//
//  DashboardState.swift
//  BankingApp
//
//  Created by Devayani Purandare on 10/07/26.
//
import Foundation

enum DashboardState : Equatable{
    case idle
    
    case loading
    
    case loaded([Account])
    
    case failure(String)
}
