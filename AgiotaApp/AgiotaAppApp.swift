//
//  AgiotaAppApp.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import SwiftUI

@main
struct AgiotaAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
