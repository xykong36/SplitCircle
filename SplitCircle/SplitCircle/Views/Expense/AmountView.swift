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
                .fontWeight(.regular) // 'regular' is equivalent to weight 400
                .foregroundColor(.secondary)
            HStack {
                TextField("Enter total bill amount", value: $expenseAmount, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
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
                        .foregroundColor(.gray) // Adjust the color as needed
                    DatePicker("", selection: $expensePaymentDate, displayedComponents: .date)
                        .labelsHidden() // Hide the default label provided by the DatePicker
                }
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("Group")
                    .font(.custom("Poppins", size: 16))
                    .fontWeight(.regular) // 'regular' is equivalent to weight 400
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
        print("reset the expensePayers...")
        expensePayers.removeAll()
    }

    private func resetExpensePayees() {
        print("reset the expensePayees...")
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
    @State private var highlightGroupSection: Bool = false
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    expenseAmountSection(expenseAmount: $expenseAmount)
                    ExpenseTitleSection(expenseTitle: $expenseTitle)
                    expensePaymentDateGroupSection(expensePaymentDate: $expensePaymentDate, expenseGroup: $expenseGroup, expensePayers: $expensePayers, expensePayees: $expensePayees, highlight: $highlightGroupSection)
                    CategorySection()
                }

                Button("Next") {
//                    print("press the save button")
//                    if expenseGroup == nil {
//                        highlightGroupSection = true
//                    } else {
//                        withAnimation {
//                            selectedSection = .whoPaid
//                        }
//                        let newActivity = Activity(title: expenseTitle, date: expensePaymentDate, groupName: expenseGroup!.name, amount: Double(expenseAmount) ?? 0.0)
//                        modelContext.insert(newActivity)
//                        print("should add a new activity")
//                    }
                    print("press the next button")
                    withAnimation {
                        selectedSection = .whoPaid
                    }
                }
                .buttonStyle(FilledButton())
                .padding()
            }
        }
        .navigationTitle("Add New Expense")
    }
}

// A custom filled button style
struct FilledButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
