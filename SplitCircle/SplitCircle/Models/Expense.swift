//
//  Expense.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import Foundation
import SwiftData

@Model
final class Expense {
    @Attribute(.unique) var id: String
    var title: String
    var amount: Double
    var expenseDate: Date
    var timestamp: Date = Date()
    var payer: String
    var payees: [Payee]
    var category: String
    var notes: String
    
    init(id: String, title: String, amount: Double, expenseDate: Date, timestamp: Date, payer: String, payees: [Payee], category: String, notes: String) {
        self.id = id
        self.title = title
        self.amount = amount
        self.expenseDate = expenseDate
        self.timestamp = timestamp
        self.payer = payer
        self.payees = payees
        self.category = category
        self.notes = notes
    }
}

