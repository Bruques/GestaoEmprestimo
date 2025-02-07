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
        NavigationView {
            ZStack {
                List {
                    Text("Teste")
                    ForEach(viewModel.contracts) { contract in
                        Text("Nome: \(contract.name ?? "nulo")")
                    }
                }
                .navigationTitle("Contratos")
                .refreshable {
                    viewModel.refresh()
                }
                .sheet(isPresented: $viewModel.showForm, content: {
                    NavigationView {
                        NewContractView(viewModel: viewModel.makeNewContractViewModel())
                    }
                })
                newContractButton
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
    }
    
    var newContractButton: some View {
        VStack {
            Text("Novo contrato")
        }
        .padding(16)
        .foregroundStyle(.white)
        .background(Color.accentColor)
        .clipShape(.capsule)
        .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        .onTapGesture {
            viewModel.showForm = true
        }
        .modifier(TapAnimationModifier())
    }
}

#Preview {
    let vm = ContractListViewModel()
    return ContractListView(viewModel: vm)
}


public struct TapAnimationModifier: ViewModifier {
    @State private var isTapped = false
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(isTapped ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isTapped)
            .onTapGesture {
                self.isTapped.toggle()
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    withAnimation {
                        self.isTapped.toggle()
                    }
                }
            }
    }
}
