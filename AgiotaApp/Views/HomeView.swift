//
//  ContentView.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label(
                        title: { Text("Dashboard") },
                        icon: { Image(systemName: "42.circle") }
                    )
                }
            
            NewContractView(viewModel: viewModel.makeNewContractViewModel())
                .tabItem {
                    Label(
                        title: { Text("New contract") },
                        icon: { Image(systemName: "plus") }
                    )
                }
            
            ContractListView()
                .tabItem {
                    Label(
                        title: { Text("Contracts") },
                        icon: { Image(systemName: "doc.plaintext") }
                    )
                }
            
            BillingView()
                .tabItem {
                    Label(
                        title: { Text("Billing") },
                        icon: { Image(systemName: "bell") }
                    )
                }
        }
    }
}

#Preview {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
}
