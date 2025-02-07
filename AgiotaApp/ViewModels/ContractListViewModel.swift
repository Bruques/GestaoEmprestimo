//
//  ContractListViewModel.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 06/02/25.
//

import Foundation
import CoreData
import Combine

class ContractListViewModel: ObservableObject {
    @Published public var contracts: [ContractEntity] = []
    @Published public var showForm: Bool = false
    private let context: NSManagedObjectContext
    private var cancellable = Set<AnyCancellable>()
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) {
        self.context = context
        fetchContracts()
    }
    
    public func refresh() {
        fetchContracts()
    }
    
    private func fetchContracts() {
        let request: NSFetchRequest<ContractEntity> = ContractEntity.fetchRequest()
        do {
            let response = try context.fetch(request)
            contracts = response
        } catch {
            print("Deu ruim")
        }
    }
    
    public func makeNewContractViewModel() -> NewContractViewModel {
        let viewModel = NewContractViewModel()
        viewModel.onSave.sink { [weak self]_ in
            self?.showForm = false
            self?.fetchContracts()
        }.store(in: &cancellable)
        return viewModel
    }
    
}
