//
//  DashboardView.swift
//  BankingApp
//
//  Created by Devayani Purandare on 10/07/26.
//
import SwiftUI
import Observation

struct DashboardView: View {
    
    @State
    private var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
       _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Dashboard View")
                
        }
        .task {
            await self.viewModel.load()
        }
    }
}

// MARK: - Content
private extension DashboardView {
    
    @ViewBuilder
    var content: some View{
        switch viewModel.state {
        case .idle:
           EmptyView()
            
        case .loading:
            ProgressView()
        
        case .loaded:
            
            accountList
            
        case .failure(let message):
            ContentUnavailableView("Unable to load view",
                                   systemImage: "wifi.exclamationmark",
                                   description: Text(message))
        }
    }
    
    
    var accountList: some View {
       List(viewModel.accounts){ account in
            VStack(alignment: .leading, spacing: 5){
                Text(account.accountName)
                    .font(.headline)
                Text(account.accountNumber)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(account.currency) \(account.balance)")
                    .font(.subheadline)
            }
            
        }
    }
}

#Preview {
        let container = AppContainer(useMockData: true)

        DashboardView(
            viewModel: container.makeDashboardViewModel()
        )
}
