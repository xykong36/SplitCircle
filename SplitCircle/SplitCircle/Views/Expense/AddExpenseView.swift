//
//  AddExpenseView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/17/24.
//

import SwiftUI

enum SelectedSectionName {
    case amount, whoPaid, forWho
}

struct AddExpenseView: View {
    @State private var currentSectionName: SelectedSectionName = .amount
    @State private var expenseAmount: Double = 0.0
    @State private var expenseTitle: String = ""
    @State private var expensePaymentDate: Date = Date()
    @State private var expenseGroup: MemberGroup? = nil
    
    // Add more state variables here and share those variables ? 
    var body: some View {
        NavigationView {
            VStack {
                // This picker will function as your segmented control for switching views
                Picker("Category", selection: $currentSectionName) {
                    Text("Amount").tag(SelectedSectionName.amount)
                    Text("Who paid?").tag(SelectedSectionName.whoPaid)
                    Text("For who?").tag(SelectedSectionName.forWho)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // How do we switch the section ? 
                // The content below the picker changes based on the selected category
                switch currentSectionName {
                case .amount:
                    AmountView(selectedSection: $currentSectionName, expenseAmount: $expenseAmount, expenseTitle: $expenseTitle, expensePaymentDate: $expensePaymentDate, expenseGroup: $expenseGroup)
                case .whoPaid:
                    WhoPaidView(selectedCategory: $currentSectionName, expenseAmount: $expenseAmount)
                case .forWho:
                    ForWhoView(expenseAmount: $expenseAmount)
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
