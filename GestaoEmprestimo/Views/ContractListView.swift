//
//  ContractListView.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import SwiftUI

struct ContractListView: View {
    @ObservedObject var viewModel: ContractListViewModel
    @Environment(\.colorScheme) var colorSheme
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.contracts) { contract in
                    NavigationLink(destination: ContractDetailView(viewModel: viewModel.makeContractDetailViewModel(contract))) {
                        contractCell(contract)
                            .listRowSeparator(.hidden)
                    }
                    .opacity(0)
                    .overlay {
                        contractCell(contract)
                    }
                }
                .onDelete(perform: viewModel.delete(at:))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.refresh()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showForm = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    })
                }
            }
            .navigationTitle("Contratos")
        }
        
        .sheet(isPresented: $viewModel.showForm,
               content: {
            NavigationView {
                ContractFormView(viewModel: viewModel.makeNewContractViewModel())
            }
        })
    }
    
    func contractCell(_ contract: ContractEntity) -> some View {
        let formattedLoanValue = contract.loanValue.formatted(.currency(code: "BRL"))
        let formattedLoanDate = contract.loanDate?.formatted(.dateTime.day().month().year()) ?? Date().formatted()
        
        return VStack(spacing: 8) {
            Text(contract.name ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
                .bold()
            HStack {
                Text(formattedLoanValue)
                Text("|")
                    .font(.title2)
                Text(formattedLoanDate)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorSheme == .dark ? Color.black : Color.white)
                .shadow(color: colorSheme == .dark ? .white.opacity(0.2) : .black.opacity(0.2),
                        radius: 8,
                        x: 0,
                        y: 0)
        )
    }
}

#Preview {
    let vm = ContractListViewModel()
    return ContractListView(viewModel: vm)
}
