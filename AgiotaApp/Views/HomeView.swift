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
                        title: { Text("Resumo") },
                        icon: { Image(systemName: "42.circle") }
                    )
                }
            
            NewContractView(viewModel: viewModel.makeNewContractViewModel())
                .tabItem {
                    Label(
                        title: { Text("Novo contrato") },
                        icon: { Image(systemName: "plus") }
                    )
                }
            
            ContractListView()
                .tabItem {
                    Label(
                        title: { Text("Contratos") },
                        icon: { Image(systemName: "doc.plaintext") }
                    )
                }
            
            BillingView()
                .tabItem {
                    Label(
                        title: { Text("Cobranças") },
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
