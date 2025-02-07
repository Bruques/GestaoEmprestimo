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
            dashboardView
            contractView
            billingView
        }
    }
    
    var dashboardView: some View {
        DashboardView()
            .tabItem {
                Label(
                    title: { Text("Resumo") },
                    icon: { Image(systemName: "42.circle") }
                )
            }
    }
    
    var contractView: some View {
        ContractListView(viewModel: viewModel.makeContractListViewModel())
            .tabItem {
                Label(
                    title: { Text("Contratos") },
                    icon: { Image(systemName: "doc.plaintext") }
                )
            }
    }
    
    var billingView: some View {
        BillingView()
            .tabItem {
                Label(
                    title: { Text("Cobranças") },
                    icon: { Image(systemName: "bell") }
                )
            }
    }
}

#Preview {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
}
