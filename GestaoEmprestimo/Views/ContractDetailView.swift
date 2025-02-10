//
//  ContractDetailView.swift
//  GestaoEmprestimo
//
//  Created by Bruno Marques on 10/02/25.
//

import SwiftUI

struct ContractDetailView: View {
    @ObservedObject var viewModel: ContractDetailViewModel
    var body: some View {
        VStack {
            Spacer().frame(height: 24)
            Text(viewModel.contract.name ?? "")
                .font(.title)
            Button("WhatApp", systemImage: "phone.circle") {
                print("teste")
            }
            .foregroundStyle(.green)
            Spacer().frame(height: 16)
            Form {
                Section("Informações do cliente") {
                    HStack {
                        Text("Endereço")
                        Spacer()
                        Text(viewModel.contract.address ?? "")
                            .foregroundStyle(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Telefone")
                        Spacer()
                        Text(viewModel.contract.phone ?? "")
                            .foregroundStyle(.gray)
                            .font(.callout)
                    }
                }
                Section("Informações do empréstimo") {
                    HStack {
                        Text("Data do empréstimo")
                        Spacer()
                        Text(viewModel.contract.loanDate?.formatted(.dateTime.day().month().year()) ?? Date().formatted())
                            .foregroundStyle(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Valor do empréstimo")
                        Spacer()
                        Text(viewModel.contract.loanValue.formatted(.currency(code: "BRL")))
                            .foregroundStyle(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Taxa de juros")
                        Spacer()
                        Text("\(viewModel.contract.interestRate.formatted(.number))")
                            .foregroundStyle(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Recorrência")
                        Spacer()
                        Text(viewModel.contract.recurrence ?? "")
                            .foregroundStyle(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Número de parcelas")
                        Spacer()
                        Text("\(viewModel.contract.installments)")
                            .foregroundStyle(.gray)
                            .font(.callout)
                    }
                }
                
            }
        }
    }
}

#Preview {
    let entity = ContractEntity(context: CoreDataStack.shared.persistentContainer.viewContext)
    entity.name = "Bruno"
    entity.address = "Rua do Bruno"
    entity.phone = "3599887766"
    entity.loanDate = Date()
    entity.loanValue = 10000
    entity.interestRate = 15
    entity.recurrence = "Mensal"
    entity.installments = 10
    entity.totalToBeReceived = 11500
    entity.profitProjection = 1500

    let viewModel = ContractDetailViewModel(contract: entity)
    return ContractDetailView(viewModel: viewModel)
}
