//
//  RootView.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import SwiftUI

struct RootView: View {
    let container: AppContainer
    var body: some View {
        DashboardView(viewModel: container.makeDashboardViewModel())
    }
}

#Preview {
    RootView(container: AppContainer())
}
