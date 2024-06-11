//
//  SplitCircleSchemaV1.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 6/9/24.
//

import Foundation
import SwiftData

enum SplitCircleSchemaV1: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [Expense.self, MemberGroup.self, User.self, ExpenseTransaction.self]
    }
    
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
    
    @Model
    final class MemberGroup {
        var id: String
        var name: String
        @Relationship var members: [User]
        var type: String?

        init(id: String, name: String, isCurrentUser: Bool = false, members: [User], type: String? = nil) {
            self.id = id
            self.name = name
            self.members = members
            self.type = type
        }
    }
    
    @Model
    final class User {
        var id: String
        var name: String
        var loginDate: Date?

        init(id: String, name: String, loginDate: Date? = nil) {
            self.id = id
            self.name = name
            self.loginDate = loginDate
        }
    }
    
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
}
