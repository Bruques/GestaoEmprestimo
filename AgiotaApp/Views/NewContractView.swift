//
//  ContractFormView.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import SwiftUI

struct NewContractView: View {
    @ObservedObject var viewModel: NewContractViewModel
    var body: some View {
        Form {
            clientInfoSection
            loanInfoSection
            loanDetailInfoSection
            newContractButton
        }
    }
    
    var clientInfoSection: some View {
        Section("Informações do cliente") {
            TextField("Nome", text: $viewModel.nome)
            TextField("Endereço", text: $viewModel.endereco)
            TextField("Telefone", text: $viewModel.telefone)
                .keyboardType(.numberPad)
        }
    }
    
    var loanInfoSection: some View {
        Section("Informações do Empréstimo") {
            DatePicker("Data do empréstimo",
                       selection: $viewModel.dataEmprestimo,
                       displayedComponents: .date)
            TextField("Valor do Empréstimo",
                      text: $viewModel.valorEmprestimo)
                .keyboardType(.decimalPad)
            TextField("Taxa de Juros (%)",
                      text: $viewModel.taxaJuros)
                .keyboardType(.decimalPad)
            Picker("Recorrência",
                   selection: $viewModel.recorrencia) {
                ForEach(Recurrence.allCases,
                        id: \.self) { item in
                    Text(item.rawValue)
                }
            }
            TextField("Número de Parcelas",
                      text: $viewModel.parcelas)
                .keyboardType(.numberPad)
        }
    }
    
    var loanDetailInfoSection: some View {
        Section(header: Text("Cálculos")) {
            HStack {
                Text("Total a Receber:")
                Spacer()
                Text("R$ \(viewModel.totalReceber, specifier: "%.2f")")
                    .foregroundColor(.blue)
            }
            HStack {
                Text("Previsão de Lucro:")
                Spacer()
                Text("R$ \(viewModel.previsaoLucro, specifier: "%.2f")")
                    .foregroundColor(.green)
            }
        }
    }
    
    var newContractButton: some View {
        Button(action: viewModel.criarContrato) {
            Text("Criar Contrato")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    let viewModel = NewContractViewModel()
    return NewContractView(viewModel: viewModel)
}
