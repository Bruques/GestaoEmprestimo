//
//  ContractDetailViewModel.swift
//  GestaoEmprestimo
//
//  Created by Bruno Marques on 10/02/25.
//

import Foundation

class ContractDetailViewModel: ObservableObject {
    @Published var contract: ContractEntity
    @Published var showForm: Bool = false
    let onSave: () -> Void
    
    init(contract: ContractEntity, onSave: @escaping () -> Void) {
        self.contract = contract
        self.onSave = onSave
    }
    
    public func onEditTap() {
        showForm = true
    }
    
    public func makeNewContractViewModel() -> ContractFormViewModel {
        return ContractFormViewModel(initialContract: contract, formType: .edition) { [weak self] in
            self?.onSave()
        }
    }
}
