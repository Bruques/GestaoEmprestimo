import Foundation

struct Contract: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let phone: String
    let loanDate: Date
    let loanValue: Double
    let interestRate: Double
    let totalToBeReceived: Double
    let profitProjection: Double
} 