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
            Text("Expenses").font(.title).bold()
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
    // limit the number of expenses show in the home page
    private let prefixCount = 5

    var body: some View {
        let displayedExpenses = prefixOnly ? Array(expenses.prefix(prefixCount)) : expenses
        NavigationStack {
            List {
                ForEach(displayedExpenses) { expense in
                    NavigationLink {
                        ExpenseDetailView(expense: expense)
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
    }

    func deleteExpenses(_ indexSet: IndexSet) {
        for index in indexSet {
            let expense = expenses[index]
            modelContext.delete(expense)
        }
    }
}


// Define a destination view for the navigation link
struct AllExpensesView: View {
    var body: some View {
        Text("All Expenses")
    }
}
