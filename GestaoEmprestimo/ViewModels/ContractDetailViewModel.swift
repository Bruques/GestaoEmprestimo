//
//  ContractDetailViewModel.swift
//  GestaoEmprestimo
//
//  Created by Bruno Marques on 10/02/25.
//

import Foundation

class ContractDetailViewModel: ObservableObject {
    @Published var contract: ContractEntity
    init(contract: ContractEntity) {
        self.contract = contract
    }
}
