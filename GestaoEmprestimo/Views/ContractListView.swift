//
//  ContractListView.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import SwiftUI

struct ContractListView: View {
    @ObservedObject var viewModel: ContractListViewModel
    var body: some View {
        Text("Contract")
    }
}

#Preview {
    let vm = ContractListViewModel()
    return ContractListView(viewModel: vm)
}
