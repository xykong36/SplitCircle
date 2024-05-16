//
//  ForWhoView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI
import SwiftData

struct ForWhoView: View {
    @Binding var expenseTitle: String
    @Binding var expenseAmount: Double
    @Binding var expensePaymentDate: Date
    @Binding var expenseGroup: MemberGroup
    @Binding var expensePayers: [User]
    @Binding var expensePayees: [User]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Text("expenseGroup Name: ")
        Text(expenseGroup.name)
        Text("Payers: ")
        ForEach(expensePayers, id: \.id) { pp in
            Text(pp.name)
        }
        Text("Payees: ")
        ForEach(expensePayees, id: \.id) { pp in
            Text(pp.name)
        }
        Button("Save") {
            let newActivity = Activity(title: expenseTitle, date: expensePaymentDate, groupName: expenseGroup.name, amount: expenseAmount)
            modelContext.insert(newActivity)
            print("add a new expense to model context")
        }
        .buttonStyle(FilledButton())
        .padding()
    }
    
    private func resetExpensePayers() {
        expensePayers.removeAll()
    }
}
