//
//  ContractFormView.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import SwiftUI

struct NewContractView: View {
    @ObservedObject var viewModel: NewContractViewModel
    @FocusState private var isFocused: Bool
    var body: some View {
        Form {
            clientInfoSection
            loanInfoSection
            loanDetailInfoSection
        }
        .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Contrato Criado"),
                    message: Text("Deseja continuar com a criação ou voltar a editar?"),
                    primaryButton: .default(Text("Continuar")) {
                        // Action to continue
                        viewModel.newContract()
                    },
                    secondaryButton: .cancel(Text("Editar")) {
                        // Action to edit
                    }
                )
            }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {}, label: {
                    Text("Voltar")
                })
            }
            ToolbarItem(placement: .principal) {
                Text("Novo contrato")
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.onSaveTap()
                }, label: {
                    Text("Salvar")
                })
            }
        }
    }
    
    var clientInfoSection: some View {
        Section("Informações do cliente") {
            TextField("Nome", text: $viewModel.name)
                .focused($isFocused)
                .onAppear(perform: {
                    isFocused = true
                })
            TextField("Endereço", text: $viewModel.address)
            TextField("Telefone", text: $viewModel.phone)
                .keyboardType(.numberPad)
        }
    }
    
    var loanInfoSection: some View {
        Section("Informações do Empréstimo") {
            DatePicker("Data do empréstimo",
                       selection: $viewModel.loanDate,
                       displayedComponents: .date)
            TextField("Valor do Empréstimo",
                      text: $viewModel.loanValue)
                .keyboardType(.decimalPad)
            TextField("Taxa de Juros (%)",
                      text: $viewModel.interestRate)
                .keyboardType(.decimalPad)
            Picker("Recorrência",
                   selection: $viewModel.recurrence) {
                ForEach(Recurrence.allCases,
                        id: \.self) { item in
                    Text(item.rawValue)
                }
            }
            TextField("Número de Parcelas",
                      text: $viewModel.installments)
                .keyboardType(.numberPad)
        }
    }
    
    var loanDetailInfoSection: some View {
        Section(header: Text("Cálculos")) {
            HStack {
                Text("Total a Receber:")
                Spacer()
                Text("R$ \(viewModel.totalToBeReceived, specifier: "%.2f")")
                    .foregroundColor(.blue)
            }
            HStack {
                Text("Previsão de Lucro:")
                Spacer()
                Text("R$ \(viewModel.profitProjection, specifier: "%.2f")")
                    .foregroundColor(.green)
            }
        }
    }
}

#Preview {
    let viewModel = NewContractViewModel()
    return NewContractView(viewModel: viewModel)
}
