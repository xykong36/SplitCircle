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
    @State private var expensePaymentDate: Date = .init()
    @State private var expenseGroup: MemberGroup = .init(name: "", createdDate: Date.now, members: [], type: nil)
    @State private var expensePayers: [User] = []
    @State private var expensePayees: [User] = []
    @State private var expenseId: UUID = UUID()
    @State private var expenseCategory: ExpenseCategory?
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                // This picker will function as your segmented control for switching views
                Picker("Category", selection: $currentSectionName) {
                    Text("Amount").tag(SelectedSectionName.amount)
                    Text("Who Paid?").tag(SelectedSectionName.whoPaid)
                    Text("For Who?").tag(SelectedSectionName.forWho)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // How do we switch the section ?
                // The content below the picker changes based on the selected category
                switch currentSectionName {
                case .amount:
                    AmountView(selectedSection: $currentSectionName, expenseAmount: $expenseAmount, expenseTitle: $expenseTitle, expensePaymentDate: $expensePaymentDate, expenseGroup: $expenseGroup, expensePayers: $expensePayers, expensePayees: $expensePayees, expenseCategory: $expenseCategory)
                case .whoPaid:
                    WhoPaidView(selectedCategory: $currentSectionName, expenseAmount: $expenseAmount, expenseGroup: $expenseGroup, expensePayers: $expensePayers)
                case .forWho:
                    ForWhoView(expenseTitle: $expenseTitle, expenseAmount: $expenseAmount, expensePaymentDate: $expensePaymentDate, expenseGroup: $expenseGroup, expensePayers: $expensePayers, expensePayees: $expensePayees, expenseId: $expenseId, isPresented: $isPresented, expenseCategory: $expenseCategory)
                }

                Spacer() // Pushes everything to the top
            }
            .navigationTitle("Add New Expense")
            .navigationBarItems(leading: Button(action: {
                isPresented = false
            }) {
                Image("Cross_Symbol")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
