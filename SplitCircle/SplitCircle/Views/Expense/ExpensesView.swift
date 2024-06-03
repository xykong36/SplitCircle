//
//  ExpensesView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 6/2/24.
//

import SwiftData
import SwiftUI

// Custom navigation bar title view with integrated "View all" button
struct ExpensesTitleView: View {
    var body: some View {
        HStack {
            Text("Activities").font(.title).bold()
            Spacer()
            NavigationLink(destination: ExpensesView(prefixOnly: false)) {
                Text("View all").foregroundColor(.accentColor)
            }
        }.padding(.horizontal)
    }
}

// Main view that includes the NavigationStack and List
struct ExpensesView: View {
    @Query(sort: \Expense.expenseDate, order: .reverse) private var expenses: [Expense]
    @Environment(\.modelContext) private var modelContext
    var prefixOnly: Bool = true
    private let prefixCount = 5 // 定义前缀数量常量

    var body: some View {
        let displayedActivities = prefixOnly ? Array(expenses.prefix(prefixCount)) : expenses

        List {
            ForEach(displayedActivities) { expense in
                NavigationLink {
                    ExpenseDetailView()
                } label: {
                    ExpenseRow(expense: expense)
                }
                // TODO: Replace hardcode UI settings
                .frame(height: 45)
                .padding(.vertical, 3)
            }
            .onDelete(perform: deleteExpenses)
        }
        // extend the edges to the screen sides
        .listStyle(.plain)
    }

    func deleteExpenses(_ indexSet: IndexSet) {
        for index in indexSet {
            let expense = expenses[index]
            modelContext.delete(expense)
        }
    }
}

// Define a destination view for the navigation link
struct ExpenseDetailView: View {
    var body: some View {
        Text("Expense name")
    }
}

// Define a destination view for the navigation link
struct AllExpensesView: View {
    var body: some View {
        Text("All Expenses")
    }
}
