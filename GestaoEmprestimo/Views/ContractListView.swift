//
//  ContractListView.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import SwiftUI

struct ContractListView: View {
    @ObservedObject var viewModel: ContractListViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.contracts) { contract in
                    Text("Cliente: \(contract.name ?? "Nulo")")
                }
            }
            .refreshable {
                viewModel.refresh()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showForm = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .navigationTitle("Contratos")
        }
        
        .sheet(isPresented: $viewModel.showForm,
               content: {
            NavigationView {
                NewContractView(viewModel: viewModel.makeNewContractViewModel())
            }
        })
    }
}

#Preview {
    let vm = ContractListViewModel()
    return ContractListView(viewModel: vm)
}
