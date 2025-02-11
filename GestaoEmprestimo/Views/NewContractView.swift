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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            clientInfoSection
            loanInfoSection
            loanDetailInfoSection
        }
        .onReceive(viewModel.$isSaved) { isSaved in
            if isSaved {
                dismiss()
            }
        }
        .alert("Você precisa preencher os campos antes de salvar", isPresented: $viewModel.showSaveAlert, actions: {
            Button("Voltar",
                   role: .cancel) {}
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    if viewModel.isFormEmpty() {
                        dismiss()
                    } else {
                        viewModel.showBackDialog = true
                    }
                }, label: {
                    Text("Voltar")
                })
                .confirmationDialog(
                    "Tem certeza que deseja cancelar?",
                    isPresented: $viewModel.showBackDialog
                ) {
                    Button("Deletar",
                           role: .destructive) {
                        dismiss()
                    }
                    Button("Cancelar",
                           role: .cancel) {}
                } message: {
                    Text("Você não poderá desfazer isso.")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.onSaveTap()
                }, label: {
                    Text("Salvar")
                        .font(.headline)
                })
            }
        }
        .navigationTitle("Novo contrato")
        .navigationBarTitleDisplayMode(.inline)
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

//#Preview {
//    let viewModel = NewContractViewModel {
//
//    }
//    return NewContractView(viewModel: viewModel)
//}

#Preview {
    let vm = ContractListViewModel()
    return ContractListView(viewModel: vm)
}
