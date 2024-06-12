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
        var expenseGroup: MemberGroup
        var notes: String?

        init(id: UUID, title: String, expenseAmount: Double, expenseDate: Date, transactions: [ExpenseTransaction], category: String, expenseGroup: MemberGroup, notes: String? = nil) {
            self.id = id
            self.title = title
            self.expenseAmount = expenseAmount
            self.expenseDate = expenseDate
            self.transactions = transactions
            self.category = category
            self.expenseGroup = expenseGroup
            self.notes = notes
        }
    }
    
    @Model
    final class MemberGroup {
        @Attribute(.unique) var id: UUID
        var name: String
        var createdDate: Date
        @Relationship var members: [User]
        var type: String?

        init(name: String, createdDate: Date, members: [User], type: String? = nil) {
            self.id = UUID()
            self.name = name
            self.createdDate = createdDate
            self.members = members
            self.type = type
        }
    }
    
    @Model
    final class User {
        @Attribute(.unique) var id: UUID
        var name: String
        var isCurrentUser: Bool
        var loginDate: Date?

        init(name: String, isCurrentUser: Bool = false, loginDate: Date? = nil) {
            self.id = UUID()
            self.name = name
            self.isCurrentUser = isCurrentUser
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
