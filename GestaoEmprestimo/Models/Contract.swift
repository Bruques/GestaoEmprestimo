//
//  Contract.swift
//  AgiotaApp
//
//  Created by Bruno Marques on 03/02/25.
//

import Foundation

class Contract: Identifiable, ObservableObject {
    @Published var name: String
    @Published var address: String
    @Published var phone: String
    @Published var loanDate: Date
    @Published var loanValue: Double
    @Published var interestRate: Double
    @Published var recurrence: Recurrence
    @Published var installments: Int
    @Published var totalToBeReceived: Double
    @Published var profitProjection: Double

    init(
        name: String,
        address: String,
        phone: String,
        loanDate: Date,
        loanValue: Double,
        interestRate: Double,
        recurrence: Recurrence,
        installments: Int,
        totalToBeReceived: Double,
        profitProjection: Double
    ) {
        self.name = name
        self.address = address
        self.phone = phone
        self.loanDate = loanDate
        self.loanValue = loanValue
        self.interestRate = interestRate
        self.recurrence = recurrence
        self.installments = installments
        self.totalToBeReceived = totalToBeReceived
        self.profitProjection = profitProjection
    }
}
