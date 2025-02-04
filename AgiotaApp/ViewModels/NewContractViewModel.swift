//
//  NewContractViewModel.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import Foundation

class NewContractViewModel: ObservableObject {
    
    @Published var nome: String = ""
    @Published var endereco: String = ""
    @Published var telefone: String = ""
    @Published var dataEmprestimo: Date = Date()
    @Published var valorEmprestimo: String = "" {
        didSet {
            self.calculate()
        }
    }

    @Published var taxaJuros: String = "" {
        didSet {
            self.calculate()
        }
    }
    
    @Published var recorrencia: Recurrence = .mensal
    @Published var parcelas: String = ""
    
    @Published var totalReceber: Double = 0.0
    @Published var previsaoLucro: Double = 0.0
    
    init() {
        
    }

    private func calculate() {
        guard let valor = Double(valorEmprestimo),
              let juros = Double(taxaJuros),
              !valorEmprestimo.isEmpty,
              !taxaJuros.isEmpty else {
            totalReceber = 0.0
            previsaoLucro = 0.0
            return
        }
        
        let jurosDecimal = juros / 100
        totalReceber = valor * (1 + jurosDecimal)
        previsaoLucro = totalReceber - valor
    }
    
    public func criarContrato() {
        let totalReceberFormatado = String(format: "R$ %.2f", totalReceber)
        let previsaoLucroFormatado = String(format: "R$ %.2f", previsaoLucro)
        
        print("Contrato criado com sucesso!")
        print("Nome: \(nome)")
        print("Endereço: \(endereco)")
        print("Telefone: \(telefone)")
        print("Valor do Empréstimo: \(valorEmprestimo)")
        print("Taxa de Juros: \(taxaJuros)%")
        print("Total a Receber: \(totalReceberFormatado)")
        print("Previsão de Lucro: \(previsaoLucroFormatado)")
    }
}
