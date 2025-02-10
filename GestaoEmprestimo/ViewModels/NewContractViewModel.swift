//
//  NewContractViewModel.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import Foundation
import Combine
import SwiftUI

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
    
    @Published var showBackDialog: Bool = false
    @Published var showSaveAlert: Bool = false
    
    @Published var isSaved: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    let onSave: () -> Void
    
    init(onSave: @escaping () -> Void) {
        self.onSave = onSave
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
    
    public func isFormEmpty() -> Bool {
        return name.isEmpty &&
            address.isEmpty &&
            loanValue.isEmpty &&
            interestRate.isEmpty &&
            installments.isEmpty
    }
    
    public func onBackTap() {
        showBackDialog = true
    }
    
    // MARK: - New contract
    public func newContract() {
        guard let value = Double(loanValue),
              let interest = Double(interestRate),
              let installments = Int(installments) else {
            print("Erro ao criar contrato: valores inválidos.")
            showSaveAlert = true
            return
        }
        
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
        isSaved = true
        onSave()
    }
}
