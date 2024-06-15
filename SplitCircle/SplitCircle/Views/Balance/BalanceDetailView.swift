//
//  MyDebtsView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/19/24.
//

import SwiftUI
import SwiftData
import os.log

struct BalanceDetailView: View {
    let allTransactions: [ExpenseTransaction]
    let totalAmount: Double
    let currentUserName: String
    @State private var showingSettled: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var filteredTransactions: [ExpenseTransaction] {
        allTransactions.filter { $0.isSettled == showingSettled }
    }
    
    var body: some View {
        let balances = calculateNetBalances(transactions: filteredTransactions, userName: currentUserName)
        let userTransactionsMap = getUserTransactionsMap(transactions: filteredTransactions, userName: currentUserName)
        VStack {
            // Header with image and total amount owed
            VStack {
                Image("DebtsDollarSign32x32")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(
                    totalAmount > 0 ? "You can collect" :
                    totalAmount < 0 ? "You owe" :
                    "No balance due"
                )
                .font(.headline)
                .foregroundColor(.secondary)
                Text("\(abs(totalAmount), specifier: "%.2f")")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(totalAmount < 0 ? .red : .green)
            }
            .padding()

            CustomToggleStyle(isSettled: $showingSettled)
                .padding(.horizontal)
            
            List {
                ForEach(balances.sorted(by: <), id: \.key) { balance in
                    DebtTransactionRow(name: balance.key, amount: balance.value, userTransactionsMap: userTransactionsMap, showingSettled: showingSettled)
                }
            }
            .navigationBarTitle("Net Balances")
        }
        .navigationTitle("Debts")
        .navigationBarTitleDisplayMode(.inline)
    }
}



struct CustomToggleStyle: View {
    @Binding var isSettled: Bool
    let totalWidth = UIScreen.main.bounds.width - 32 // 32 is the total horizontal padding you might have added

    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.gray.opacity(0.6))
                .frame(width: totalWidth, height: 50)

            // Highlighted background that moves
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.blue)
                .frame(width: totalWidth / 2, height: 48) // The width is half of the toggle's total width
                .offset(x: isSettled ? totalWidth / 4 : -totalWidth / 4) // The offset is a quarter of the total width
                .animation(.easeInOut(duration: 0.3), value: isSettled)

            // Text
            HStack {
                Button("Unsettled") {
                    withAnimation { isSettled = false }
                }
                .frame(width: totalWidth / 2) // Half the width of the toggle

                Button("Settled") {
                    withAnimation { isSettled = true }
                }
                .frame(width: totalWidth / 2) // Half the width of the toggle
            }
            .font(.headline.bold())
            .foregroundColor(.white)
        }
        .frame(width: totalWidth, height: 50) // Set the height of the entire component
    }
}

// Row view for each debt transaction
struct DebtTransactionRow: View {
    @State private var showingEditModal = false
    let name: String
    let amount: Double
    let userTransactionsMap: [String: [ExpenseTransaction]]
    let showingSettled: Bool

    var body: some View {
        HStack {
            Text(name)
                .font(.headline)
                .padding(.vertical, 15)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text(String(format: "%.2f", amount))
                .font(.headline)
                .fontWeight(.bold)
                .padding(.vertical, 2) // Add more padding to make the row thicker
                .foregroundColor(amount > 0 ? .green : (amount == 0 ? .black : .red))
        }
        .cornerRadius(10)
        .swipeActions(edge: .trailing) {
            if !showingSettled {
                Button(action: {
                    settleTransactions(transactions: userTransactionsMap[name])
                }) {
                    Text("Settle Up")
                }
                .tint(.blue)
            }
        }
    }
}


private func settleTransactions(transactions: [ExpenseTransaction]?) {
    // Check if transactions is nil or empty
    guard let transactions = transactions else {
        os_log("No transactions to settle.", log: OSLog.default, type: .info)
        return
    }

    transactions.indices.forEach { index in
        transactions[index].isSettled = true
    }
}
