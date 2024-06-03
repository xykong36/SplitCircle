//
//  Transaction.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 5/15/24.
//

import Foundation
import SwiftData

@Model
final class ExpenseTransaction {
    @Attribute(.unique) var id: UUID
    var expenseTitle: String
    var payer: User
    var payee: User
    var amount: Double
    var transactionDate: Date
    var isSettled: Bool
    var settledDate: Date?
    var expenseId: UUID

    init(expenseTitle: String, payer: User, payee: User, amount: Double, transactionDate: Date, isSettled: Bool, settledDate: Date? = nil, expenseId: UUID) {
        self.id = UUID()
        self.expenseTitle = expenseTitle
        self.payer = payer
        self.payee = payee
        self.amount = amount
        self.transactionDate = transactionDate
        self.isSettled = isSettled
        self.settledDate = settledDate
        self.expenseId = expenseId
    }
}
