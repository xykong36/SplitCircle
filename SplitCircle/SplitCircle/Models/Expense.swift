//
//  Expense.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.

import Foundation
import SwiftData

@Model
final class Expense {
    @Attribute(.unique) var id: UUID
    var title: String
    var expenseAmount: Double
    var expenseDate: Date
    var payers: [User]
    var payees: [User]
    var transactions: [ExpenseTransaction] = []
    var category: String
    var notes: String?

    init(title: String, expenseAmount: Double, expenseDate: Date, payers: [User], payees: [User], transactions: [ExpenseTransaction], category: String, notes: String? = nil) {
        self.id = UUID()
        self.title = title
        self.expenseAmount = expenseAmount
        self.expenseDate = expenseDate
        self.payers = payers
        self.payees = payees
        self.transactions = transactions
        self.category = category
        self.notes = notes
    }
}
