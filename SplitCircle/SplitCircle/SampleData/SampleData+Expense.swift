//
//  SampleData+Expense.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import Foundation
import SwiftData

extension Expense {
    
    static let calendar = Calendar.current
    static let expenseDateComponents = DateComponents(year: 2023, month: 3, day: 15)
    static let expenseDate = calendar.date(from: expenseDateComponents)!
    static let payees: [Payee] = [Payee(id: "1", name: "Alice", amount: 40), Payee(id: "2", name: "Bob", amount: 50.0)]
    
    static let BBQExpense = Expense(id: UUID().uuidString,
                              title: "BBQ Test",
                              amount: 120.0,
                              expenseDate: expenseDate,
                              payer: "John",
                              payees: payees,
                              category: "Food",
                              notes: "This is a test expense for BBQ.")
    
    static let groceryExpense = Expense(id: UUID().uuidString,
                                 title: "Grocery Shopping",
                                 amount: 85.0,
                                 expenseDate: expenseDate,
                                 payer: "Alice",
                                 payees: payees,
                                 category: "Grocery",
                                 notes: "This is a test expense for grocery shopping.")
    
    static let dinningExpense = Expense(id: UUID().uuidString,
                                 title: "Dinning Out",
                                 amount: 65.0,
                                 expenseDate: expenseDate,
                                 payer: "Bob",
                                 payees: payees,
                                 category: "Restaurant",
                                 notes: "This is a test expense for dinning out.")
    
    
    static let user1 = User(id: "1", email: "test1@a.com", name: "Alice")
    static let user2 = User(id: "2", email: "test2@a.com", name: "Bob")
    static let user3 = User(id: "3", email: "test3@a.com", name: "Charlie")

    static let group1 = MemberGroup(id: "group1", members: [user1, user2], name: "Group 1", type: "Type A")
    static let group2 = MemberGroup(id: "group2", members: [user2, user3], name: "Group 2", type: "Type B")
    static let group3 = MemberGroup(id: "group3", members: [user1, user3], name: "Group 3")
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(BBQExpense)
        modelContext.insert(groceryExpense)
        modelContext.insert(dinningExpense)
        modelContext.insert(group1)
        modelContext.insert(group2)
        modelContext.insert(group3)
    }

}
