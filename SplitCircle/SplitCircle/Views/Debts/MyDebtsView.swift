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
        DebtTransaction(name: "Eason", amount: 0.00, isSettled: true),
    ]
    @State private var showingSettled: Bool = false
    @Environment(\.presentationMode) var presentationMode

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
            CustomToggleStyle(isSettled: $showingSettled)
                .padding(.horizontal)

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

struct CustomToggleStyle: View {
    @Binding var isSettled: Bool
    let totalWidth = UIScreen.main.bounds.width - 32 // 32 is the total horizontal padding you might have added

    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.gray.opacity(0.2))
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
    let transaction: DebtTransaction

    var body: some View {
        HStack {
            Text(transaction.name)
                .font(.headline)
                .padding(.vertical, 15)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text(transaction.amountText)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.vertical, 2) // Add more padding to make the row thicker
                .foregroundColor(transaction.amount > 0 ? .green : (transaction.amount == 0 ? .black : .red))
        }
        .background(Color.white)
        .cornerRadius(10)
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
