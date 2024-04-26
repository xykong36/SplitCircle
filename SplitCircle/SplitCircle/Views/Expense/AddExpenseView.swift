//
//  AddExpenseView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/17/24.
//

import SwiftUI

enum ExpenseCategory {
    case amount, whoPaid, forWho
}

struct AddExpenseView: View {
    @State private var selectedCategory: ExpenseCategory = .amount
    var body: some View {
        NavigationView {
            VStack {
                // This picker will function as your segmented control for switching views
                Picker("Category", selection: $selectedCategory) {
                    Text("Amount").tag(ExpenseCategory.amount)
                    Text("Who paid?").tag(ExpenseCategory.whoPaid)
                    Text("For who?").tag(ExpenseCategory.forWho)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // The content below the picker changes based on the selected category
                switch selectedCategory {
                case .amount:
                    AddAmountView()
                case .whoPaid:
                    WhoPaidView()
                case .forWho:
                    ForWhoView()
                }

                Spacer() // Pushes everything to the top
            }
            .navigationTitle("Add New Expense")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

#Preview {
    AddExpenseView()
}
