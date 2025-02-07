//
//  NewContractViewModel.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import Foundation
import CoreData
import Combine

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
    
    var contract: Contract?
    
    @Published var showAlert: Bool = false
    
    private let context: NSManagedObjectContext
    
    public var onSave = PassthroughSubject<Void, Never>()
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) {
        self.context = context
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
    
    public func newContract() {
        guard let value = Double(loanValue),
              let interest = Double(interestRate),
              let installments = Int(installments) else {
            print("Erro ao criar contrato: valores inválidos.")
            return
        }
        
//        let formattedTotalToBeReceived = String(format: "R$ %.2f", totalToBeReceived)
//        let formattedProfitProjection = String(format: "R$ %.2f", profitProjection)
        
        let contract = Contract(
            name: name,
            address: address,
            phone: phone,
            loanDate: loanDate,
            loanValue: value,
            interestRate: interest, 
            recurrence: recurrence,
            installments: installments,
            totalToBeReceived: totalToBeReceived,
            profitProjection: profitProjection
        )
        
        self.contract = contract
//        self.showAlert = true
        
        let contractEntity = ContractEntity(context: CoreDataStack.shared.persistentContainer.viewContext)
        contractEntity.name = name
        contractEntity.address = address
        contractEntity.phone = phone
        contractEntity.loanDate = loanDate
        contractEntity.loanValue = value
        contractEntity.interestRate = interest
        contractEntity.recurrence = recurrence.rawValue
        contractEntity.installments = Int16(installments)
        contractEntity.totalToBeReceived = totalToBeReceived
        contractEntity.profitProjection = profitProjection
        
        do {
            try context.save()
            print("Contrato criado com sucesso!")
            onSave.send(())
        } catch {
            print("erro no save")
        }
        
        
        
//        print("Contrato criado com sucesso!")
//        print("Nome: \(name)")
//        print("Endereço: \(address)")
//        print("Telefone: \(phone)")
//        print("Data do emprestimo: \(loanDate)")
//        print("Valor do Empréstimo: \(loanValue)")
//        print("Taxa de Juros: \(interestRate)%")
//        print("Total a Receber: \(formattedTotalToBeReceived)")
//        print("Previsão de Lucro: \(formattedProfitProjection)")
    }
}
