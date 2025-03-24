//
//  ContractListViewModel.swift
//  GestaoEmprestimo
//
//  Created by Bruno Marques on 07/02/25.
//

import Foundation
import CoreData

class ContractListViewModel: ObservableObject {
    @Published public var showForm: Bool = false
    
    @Published public var contracts: [ContractEntity] = []
    let viewContext = CoreDataStack.shared.persistentContainer.viewContext
    
    init() {
        fetchContracts()
    }
    
    private func fetchContracts() {
        let request = NSFetchRequest<ContractEntity>(entityName: "ContractEntity")
        do {
            let response = try CoreDataStack.shared.persistentContainer.viewContext.fetch(request)
            contracts = response
        } catch {
            print("Fetch contracts error: \(error.localizedDescription)")
        }
    }
    
    public func refresh() {
        fetchContracts()
    }
    
    // MARK: - Delete item
    public func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let contract = contracts[index]
            viewContext.delete(contract)
        }
    }
    
    // MARK: - Make new contract view model
    public func makeNewContractViewModel() -> ContractFormViewModel {
        return ContractFormViewModel(formType: .creation) { [weak self] in
            self?.refresh()
        }
    }
    
    public func makeContractDetailViewModel(_ contract: ContractEntity) -> ContractDetailViewModel {
        return ContractDetailViewModel(contract: contract) { [weak self] in
            self?.refresh()
        }
    }
}
