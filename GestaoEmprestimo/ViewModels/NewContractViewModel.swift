//
//  NewContractViewModel.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import Foundation

class NewContractViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var phone: String = ""
    @Published var loanDate: Date = Date()
    @Published var loanValue: String = "" {
        didSet {
            self.calculate()
        }
    }
    @Published var interestRate: String = "" {
        didSet {
            self.calculate()
        }
    }
    @Published var recurrence: Recurrence = .mensal
    @Published var installments: String = ""
    @Published var totalToBeReceived: Double = 0.0
    @Published var profitProjection: Double = 0.0
    
    @Published var showAlert: Bool = false
    
    init() {
        
    }

    private func calculate() {
        guard let value = Double(loanValue),
              let interest = Double(interestRate),
              !loanValue.isEmpty,
              !interestRate.isEmpty else {
            totalToBeReceived = 0.0
            profitProjection = 0.0
            return
        }
        
        let decimalInterest = interest / 100
        totalToBeReceived = value * (1 + decimalInterest)
        profitProjection = totalToBeReceived - value
    }
    
    public func onSaveTap() {
        self.showAlert = true
    }
    
    public func newContract() {
        guard let value = Double(loanValue),
              let interest = Double(interestRate),
              let installments = Int(installments) else {
            print("Erro ao criar contrato: valores inválidos.")
            return
        }
        
        let formattedTotalToBeReceived = String(format: "R$ %.2f", totalToBeReceived)
        let formattedProfitProjection = String(format: "R$ %.2f", profitProjection)
        
        let contract = ContractEntity(context: CoreDataStack.shared.persistentContainer.viewContext)
        contract.name = name
        contract.address = address
        contract.phone = phone
        contract.loanDate = loanDate
        contract.loanValue = value
        contract.interestRate = interest
        contract.recurrence = recurrence.rawValue
        contract.installments = Int16(installments)
        contract.totalToBeReceived = totalToBeReceived
        contract.profitProjection = profitProjection
        
        CoreDataStack.shared.save()
    }
}
