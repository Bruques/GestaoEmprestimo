//
//  NewContractViewModel.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import Foundation
import Combine
import SwiftUI

class ContractFormViewModel: ObservableObject {
    enum FormType {
        case creation
        case edition
    }
    
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
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
    @Published var formType: FormType
    
    let initialContract: ContractEntity?
    let onSave: () -> Void
    
    private var cancellables = Set<AnyCancellable>()
    
    init(initialContract: ContractEntity? = nil,
         formType: FormType,
         onSave: @escaping () -> Void) {
        self.initialContract = initialContract
        self.onSave = onSave
        self.formType = formType
        
        if let initialContract {
            name = initialContract.name ?? ""
            address = initialContract.address ?? ""
            phone = initialContract.phone ?? ""
            email = initialContract.email ?? ""
            loanDate = initialContract.loanDate ?? Date()
            loanValue = "\(initialContract.loanValue)"
            interestRate = "\(initialContract.interestRate)"
            recurrence = Recurrence(rawValue: initialContract.recurrence ?? "Mensal") ?? .mensal
            installments = "\(initialContract.installments)"
            totalToBeReceived = initialContract.totalToBeReceived
            profitProjection = initialContract.profitProjection
        }
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
    
    // MARK: - Has changes
    public func hasChanges() -> Bool {
        switch formType {
            case .creation:
                return !name.isEmpty ||
                       !address.isEmpty ||
                       !phone.isEmpty ||
                       !email.isEmpty ||
                       !loanValue.isEmpty ||
                       !interestRate.isEmpty ||
                       !installments.isEmpty
                       
            case .edition:
            guard let initialContract else { return false }
                return name != initialContract.name ||
                       address != initialContract.address ||
                       phone != initialContract.phone ||
                       email != initialContract.email ||
                       loanValue != String(initialContract.loanValue) ||
                       interestRate != String(initialContract.interestRate) ||
                       installments != String(initialContract.installments)
            }
    }
    
    public func onBackTap() {
        showBackDialog = true
    }
    
    // MARK: - On save tap
    public func onSaveTap() {
        switch formType {
        case .creation:
            newContract()
        case .edition:
            updateContract()
        }
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
        contract.email = email
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
    
    // MARK: - Update contract
    public func updateContract() {
        guard let value = Double(loanValue),
              let interest = Double(interestRate),
              let installments = Int(installments) else {
            print("Erro ao criar contrato: valores inválidos.")
            showSaveAlert = true
            return
        }
        
        initialContract?.name = name
        initialContract?.address = address
        initialContract?.phone = phone
        initialContract?.email = email
        initialContract?.loanDate = loanDate
        initialContract?.loanValue = value
        initialContract?.interestRate = interest
        initialContract?.recurrence = recurrence.rawValue
        initialContract?.installments = Int16(installments)
        initialContract?.totalToBeReceived = totalToBeReceived
        initialContract?.profitProjection = profitProjection
        
        CoreDataStack.shared.save()
        isSaved = true
        onSave()
    }
}
