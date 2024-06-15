//
//  ExpenseRow.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 6/2/24.
//

import SwiftUI

struct ExpenseRow: View {
    @Environment(\.colorScheme) var colorScheme
    var expense: Expense
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()

    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .overlay(
                HStack(spacing: 3) {
                    CategoryIconView(categoryIcon: expense.category)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(expense.title)
                            .font(.headline)
                            .padding(.vertical, 3)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        HStack(spacing: 4) {
                            Text(dateFormatter.string(from: expense.expenseDate))
                                .font(.subheadline)
                                .frame(minWidth: 10, maxWidth: 100, alignment: .leading)
                                .foregroundColor(.gray)
                            Text(expense.expenseGroup.name)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    if let amountString = currencyFormatter.string(from: NSNumber(value: expense.expenseAmount)) {
                        Text(amountString)
                            .kerning(0.2)
                            .frame(minWidth: 18, maxWidth: 100, alignment: .trailing)
                            .fontWeight(.bold)
                            .font(.body)
                    }
                }
            )
    }
}

struct CategoryIconView: View {
    let categoryIcon: String

    var iconImageName: String {
        categoryIcon + "Round40x40"  // Compute the complete image name here
    }
    
    var body: some View {
        Image(iconImageName)
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .padding(EdgeInsets(top: 30, leading: 5, bottom: 25, trailing: 10))
    }
}
