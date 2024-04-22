//
//  MyDebtsView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/19/24.
//

import SwiftUI

struct MyDebtsView: View {
    // Sample transactions data
    @State private var transactions: [DebtTransaction] = [
        DebtTransaction(name: "Alice", amount: 17.67, isSettled: false),
        DebtTransaction(name: "Bob", amount: -33.00, isSettled: false),
        DebtTransaction(name: "Charlie", amount: -127.50, isSettled: false),
        DebtTransaction(name: "Diana", amount: 0.00, isSettled: true),
    ]
    @State private var showingSettled: Bool = false

    var filteredTransactions: [DebtTransaction] {
        transactions.filter { $0.isSettled == showingSettled }
    }

    var totalOwed: Double {
        // Compute the total amount owed
        transactions.filter { !$0.isSettled }.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack {
            // Header with image and total amount owed
            VStack {
                Image("Debts_Dollar_Sign")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("You owed:")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("$\(totalOwed, specifier: "%.2f")")
                    .font(.largeTitle)
                    .bold()
            }
            .padding()

            // Toggle for Unsettled and Settled
            HStack {
                Button("Unsettled") {
                    withAnimation { showingSettled = false }
                }
                .buttonStyle(ToggleButtonStyle(isSelected: !showingSettled))

                Button("Settled") {
                    withAnimation { showingSettled = true }
                }
                .buttonStyle(ToggleButtonStyle(isSelected: showingSettled))
            }
            .padding()

            // Transactions List
            List {
                ForEach(filteredTransactions) { transaction in
                    DebtTransactionRow(transaction: transaction)
                }
            }
        }
        .navigationTitle("Debts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ToggleButtonStyle: ButtonStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(isSelected ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// Row view for each debt transaction
struct DebtTransactionRow: View {
    let transaction: DebtTransaction

    var body: some View {
        HStack {
            Text(transaction.name)
                .font(.headline)
            Spacer()
            Text(transaction.amountText)
                .foregroundColor(transaction.amount > 0 ? .green : (transaction.amount == 0 ? .black : .red))
        }
    }
}

// A mock model to represent a debt transaction
struct DebtTransaction: Identifiable {
    let id = UUID()
    var name: String
    var amount: Double
    var isSettled: Bool

    var amountText: String {
        let sign = amount > 0 ? "+" : ""
        return "\(sign)\(amount) USD"
    }
}

#Preview {
    MyDebtsView()
}
