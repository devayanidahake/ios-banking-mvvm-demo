//
//  RootView.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import SwiftUI

struct RootView: View {

    var body: some View {
        NavigationStack {
            Text("🏦 Banking App")
                .navigationTitle("Home")
        }
    }
}

#Preview {
    RootView()
}
