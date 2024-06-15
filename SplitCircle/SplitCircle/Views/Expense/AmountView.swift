//
//  AmountView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftData
import SwiftUI

struct expenseAmountSection: View {
    @Binding var expenseAmount: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text("Bill Amount")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular)
                .foregroundColor(.secondary)
            HStack {
                TextField("Enter total bill amount", value: $expenseAmount, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                Text("USD")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct ExpenseTitleSection: View {
    @Binding var expenseTitle: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Expense Title")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .lineSpacing(3.2)

            TextField("Describe this expense", text: $expenseTitle)
                .keyboardType(.default)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct expensePaymentDateGroupSection: View {
    @Query private var groups: [MemberGroup]
    @Environment(\.modelContext) private var modelContext
    @Binding var expensePaymentDate: Date
    @Binding var expenseGroup: MemberGroup
    @Binding var expensePayers: [User]
    @Binding var expensePayees: [User]
    @Binding var highlight: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Payment Date")
                    .font(.custom("Poppins", size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)

                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    DatePicker("", selection: $expensePaymentDate, displayedComponents: .date)
                        .labelsHidden()
                }
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("Group")
                    .font(.custom("Poppins", size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)

                Menu {
                    ForEach(groups, id: \.self) { group in
                        Button(group.name) {
                            expenseGroup = group
                        }
                    }
                    .onChange(of: expenseGroup) {
                        resetExpensePayers()
                        resetExpensePayees()
                    }
                } label: {
                    HStack {
                        Text(expenseGroup.name.isEmpty ? "Select Group" : expenseGroup.name)
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .foregroundColor(.gray)
                    .background(highlight && expenseGroup.name == "" ? Color.red.opacity(0.3) : Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 1)
            }
            .padding(.horizontal)
        }
    }

    private func resetExpensePayers() {
        expensePayers.removeAll()
    }

    private func resetExpensePayees() {
        expensePayees.removeAll()
    }
}

struct AmountView: View {
    @Binding var selectedSection: SelectedSectionName
    @Binding var expenseAmount: Double
    @Binding var expenseTitle: String
    @Binding var expensePaymentDate: Date
    @Binding var expenseGroup: MemberGroup
    @Binding var expensePayers: [User]
    @Binding var expensePayees: [User]
    @Binding var expenseCategory: ExpenseCategory?
    @State private var highlightGroupSection: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    // Computed property to check if all required fields are filled
    private var isNextButtonEnabled: Bool {
        expenseAmount > 0 &&
        !expenseTitle.isEmpty &&
        !expenseGroup.name.isEmpty &&
        expenseCategory != nil
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    expenseAmountSection(expenseAmount: $expenseAmount)
                    ExpenseTitleSection(expenseTitle: $expenseTitle)
                    expensePaymentDateGroupSection(expensePaymentDate: $expensePaymentDate, expenseGroup: $expenseGroup, expensePayers: $expensePayers, expensePayees: $expensePayees, highlight: $highlightGroupSection)
                    CategorySection(expenseCategory: $expenseCategory)
                }

                Button("Next") {
                    withAnimation {
                        selectedSection = .whoPaid
                    }
                }
                .disabled(!isNextButtonEnabled)
                .buttonStyle(FilledButtonWithDisable(isEnabled: isNextButtonEnabled))
                .padding()
            }
        }
        .navigationTitle("Add New Expense")
    }
}


