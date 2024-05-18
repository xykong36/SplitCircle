//
//  Utils.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 5/18/24.
//

import Foundation

func createTransactions(expenseAmount: Double, expenseTitle: String, expensePayees: [User], expensePayers: [User]) -> [ExpenseTransaction] {
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
                        // TODO: replace expenseId
                        expenseId: UUID()
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
