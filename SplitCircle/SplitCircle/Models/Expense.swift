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
    var transactions: [ExpenseTransaction] = []
    var category: String
    var notes: String?

    init(id: UUID, title: String, expenseAmount: Double, expenseDate: Date, transactions: [ExpenseTransaction], category: String, notes: String? = nil) {
        self.id = id
        self.title = title
        self.expenseAmount = expenseAmount
        self.expenseDate = expenseDate
        self.transactions = transactions
        self.category = category
        self.notes = notes
    }
}
