//
//  AddAmountView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI
import SwiftData

struct BillAmountSection: View {
    @Binding var billAmount: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bill Amount")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular) // 'regular' is equivalent to weight 400
                .foregroundColor(.secondary)
            HStack {
                TextField("Enter total bill amount", text: $billAmount)
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

struct PaymentDateGroupSection: View {
    @Query private var groups: [MemberGroup]
    @Environment(\.modelContext) private var modelContext
    @Binding var paymentDate: Date
    @Binding var selectedGroup: MemberGroup?
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
                    DatePicker("", selection: $paymentDate, displayedComponents: .date)
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
                            selectedGroup = group
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedGroup?.name ?? "Select group")
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .foregroundColor(.gray)
                    .background(highlight && selectedGroup == nil ? Color.red.opacity(0.3) : Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 1)
            }
            .padding(.horizontal)
        }
    }
}

struct AddAmountView: View {
    @Binding var selectedCategory: SelectedSectionName
    @State private var billAmount: String = ""
    @State private var expenseTitle: String = ""
    @State private var paymentDate: Date = Date()
    @State private var selectedGroup: MemberGroup? = nil
    @State private var highlightGroupSection: Bool = false
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    BillAmountSection(billAmount: $billAmount)
                    ExpenseTitleSection(expenseTitle: $expenseTitle)
                    PaymentDateGroupSection(paymentDate: $paymentDate, selectedGroup: $selectedGroup, highlight: $highlightGroupSection)
                    CategorySection()
                }

                Button("Next") {
                    print("press the save button")
                    if selectedGroup == nil {
                        highlightGroupSection = true
                    } else {
                        withAnimation {
                            selectedCategory = .whoPaid
                        }
                        let newActivity = Activity(title: expenseTitle, date: paymentDate, groupName: selectedGroup!.name, amount: Double(billAmount) ?? 0.0)
                        modelContext.insert(newActivity)
                        print("should add a new activity")
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
