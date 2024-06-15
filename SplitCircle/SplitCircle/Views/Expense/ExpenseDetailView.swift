//
//  ExpenseDetailView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 6/8/24.
//

import SwiftUI

struct ExpenseDetailView: View {
    var expense: Expense
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                transactionDetails
            }
        }
        .navigationBarTitle("Expense Details", displayMode: .inline)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                CategoryIconView(categoryIcon: expense.category)
                VStack(alignment: .leading) {
                    Text(expense.title)
                        .fontWeight(.bold)
                    Text(dateFormatter.string(from: expense.expenseDate))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text("\(expense.expenseAmount, specifier: "%.2f") USD")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
            .padding()
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
    private var transactionDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(expense.transactions, id: \.id) { transaction in
                transactionRow(for: transaction)
            }
        }
        .padding()
    }
    
    private func transactionRow(for transaction: ExpenseTransaction) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(transaction.payee.name) owes \(transaction.payer.name)")
                    .font(.headline)
                Text("\(transaction.amount, specifier: "%.2f") USD")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}
