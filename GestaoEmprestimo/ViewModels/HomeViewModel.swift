//
//  HomeViewModel.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    public func makeContractListViewModel() -> ContractListViewModel {
        return ContractListViewModel()
    }
}
