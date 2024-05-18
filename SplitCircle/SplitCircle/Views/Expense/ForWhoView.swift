//
//  ForWhoView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftData
import SwiftUI

struct ForWhoView: View {
    @Binding var expenseTitle: String
    @Binding var expenseAmount: Double
    @Binding var expensePaymentDate: Date
    @Binding var expenseGroup: MemberGroup
    @Binding var expensePayers: [User]
    @Binding var expensePayees: [User]
    @Environment(\.modelContext) private var modelContext

    var payeeSplitAmount: Double {
        guard !expensePayees.isEmpty else { return 0 }
        return expenseAmount / Double(expensePayees.count)
    }
    
    // TODO: Figure out transaction details and save in modelContext
    var body: some View {
//        Text("expenseGroup Name: ")
//        Text(expenseGroup.name)
//        Text("Payers: ")
//        ForEach(expensePayers, id: \.id) { pp in
//            Text(pp.name)
//        }
//        Text("Payees: ")
//        ForEach(expensePayees, id: \.id) { pp in
//            Text(pp.name)
//        }
        VStack {
            AmountTitleSection(expenseAmount: $expenseAmount)
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("For Who?")
                        .font(.custom("Poppins", size: 20))
                        .foregroundColor(.secondary)
                        .fontWeight(.regular)
                        .padding(.leading, 20)
                    MembersToggleSection(members: $expenseGroup.members, selectedMembers: $expensePayees, splitAmount: payeeSplitAmount)
                }
                Button("Save") {
                    let newActivity = Activity(title: expenseTitle, date: expensePaymentDate, groupName: expenseGroup.name, amount: expenseAmount)
                    modelContext.insert(newActivity)
                    
                    
//                    let newTransaction = createTransactions(expenseAmount: <#T##Double#>, expenseTitle: <#T##String#>, expensePayees: <#T##[User]#>, expensePayers: <#T##[User]#>)
//
//                    let newExpense = Expense(title: expenseTitle, expenseAmount: expenseAmount, expenseDate: expensePaymentDate, payers: expensePayers, payees:  expensePayers, transactions: [], category: "ab")
//                    let newTransaction = Transaction()
                    print("add a new expense to model context")
                }
                .buttonStyle(FilledButton())
                .padding()
            }
        }
        .navigationTitle("Add New Expense")
    }
//    
    


    private func resetExpensePayers() {
        expensePayers.removeAll()
    }
}
