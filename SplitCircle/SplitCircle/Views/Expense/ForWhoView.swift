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
    @Binding var expenseId: UUID
    @Binding var isPresented: Bool
    @Binding var expenseCategory: ExpenseCategory?
    @State private var savedNewExpense = false
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Query private var allExpenses: [Expense]
    let alertTitle: String = "Successfully add a new expense."

    var payeeSplitAmount: Double {
        guard !expensePayees.isEmpty else { return 0 }
        return expenseAmount / Double(expensePayees.count)
    }
    
    var body: some View {
//        Text("Expenses: ")
//        ForEach(allExpenses, id: \.id) { pp in
//            Text(pp.title)
//            Text(String(pp.expenseAmount))
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
                    let newTransactions = createTransactions()
                    let newExpense = Expense(id: expenseId,title: expenseTitle, expenseAmount: expenseAmount, expenseDate: expensePaymentDate, transactions: newTransactions, category: expenseCategory?.rawValue ?? "Other")
                    modelContext.insert(newExpense)
                    savedNewExpense = true
                }
                .buttonStyle(FilledButton())
                .padding()
            }
        }
        .navigationTitle("Add New Expense")
        .alert(
            alertTitle,
            isPresented: $savedNewExpense
        ) {
            Button("OK") {
                isPresented = false
            }
        }
    }
    
    func createTransactions() -> [ExpenseTransaction] {
        var transactions: [ExpenseTransaction] = []

        // Calculate the share for each payee
        let payeeShare = expenseAmount / Double(expensePayees.count)

        // Dictionary to track each payee's remaining amount to pay
        var payeeAmounts = [String: Double]()
        for payee in expensePayees {
            payeeAmounts[String(payee.id)] = payeeShare
        }

        // Calculate each payer's actual amount paid for others
        for payer in expensePayers {
            let payerAmount = expenseAmount / Double(expensePayers.count)
            let payerShare = payerAmount - payeeShare // The amount the payer paid for others
            var remainingPayerShare = payerShare

            for payee in expensePayees {
                // Check if payer and payee are different
                if payer.id != payee.id {
                    // Calculate the amount payee needs to pay to this payer
                    let payeeIdString = String(payee.id)
                    let amount = min(remainingPayerShare, payeeAmounts[payeeIdString]!)
                    if amount > 0 {
                        let transaction = ExpenseTransaction(
                            expenseTitle: expenseTitle,
                            payer: payer,
                            payee: payee,
                            amount: amount,
                            transactionDate: Date(),
                            isSettled: false,
                            expenseId: expenseId
                        )
                        transactions.append(transaction)
                        payeeAmounts[payeeIdString]! -= amount
                        remainingPayerShare -= amount
                    }
                }
            }
        }

        return transactions
    }

    private func resetExpensePayers() {
        expensePayers.removeAll()
    }
}
