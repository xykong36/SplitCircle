//
//  SharedView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 6/7/24.
//

import SwiftUI
import SwiftData

struct BalanceView: View {
    @State private var showingDebtsSheet = false
    @Query private var allTransactions: [ExpenseTransaction]
    @Binding var currentUserName: String
    var unsettledTransactions: [ExpenseTransaction] {
        allTransactions.filter { $0.isSettled == false }
    }
    var body: some View {
        let unsettledBalances = calculateNetBalances(transactions: unsettledTransactions, userName: currentUserName)
        let totalAmount = unsettledBalances.values.reduce(0, +)
        // Balance Card
        Button(action: {
            showingDebtsSheet = true
        }) {
            BalanceCardView(unsettledTransactions: unsettledTransactions, totalAmount: totalAmount).padding()
        }
        .sheet(isPresented: $showingDebtsSheet) {
            BalanceDetailView(allTransactions: allTransactions, totalAmount: totalAmount, currentUserName: currentUserName)
        }
    }
}

func calculateNetBalances(transactions: [ExpenseTransaction], userName: String) -> [String: Double] {
    var netBalances = [String: Double]()

    // Transactions where user is the payer
    let payerTransactions = transactions.filter { $0.payer.name == userName }
    for transaction in payerTransactions {
        let payeeName = transaction.payee.name
        netBalances[payeeName, default: 0] += transaction.amount
    }

    // Transactions where user is the payee
    let payeeTransactions = transactions.filter { $0.payee.name == userName }
    for transaction in payeeTransactions {
        let payerName = transaction.payer.name
        netBalances[payerName, default: 0] -= transaction.amount
    }

    return netBalances
}
