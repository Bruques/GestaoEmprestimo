//
//  ContractListViewModel.swift
//  GestaoEmprestimo
//
//  Created by Bruno Marques on 07/02/25.
//

import Foundation
import CoreData

class ContractListViewModel: ObservableObject {
    @Published public var contracts: [ContractEntity] = []
    
    init() {
        fetchContracts()
    }
    
    private func fetchContracts() {
        let request = NSFetchRequest<ContractEntity>(entityName: "ContractEntity")
        do {
            let response = try CoreDataStack.shared.persistentContainer.viewContext.fetch(request)
            contracts = response
            print("Fetch contract success! \(response)")
        } catch {
            print("Fetch contracts error: \(error.localizedDescription)")
        }
    }
}
