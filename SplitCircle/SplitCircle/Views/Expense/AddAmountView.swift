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
    @Binding var paymentDate: Date
    @Binding var selectedGroup: MemberGroup?

    var body: some View {
        HStack {
            PaymentDateView()
            SelectGroupView()
        }
    }
}
struct PaymentDateView: View {
    @State private var selectedDate = Date() // Default to current date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Payment Date")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular)
                .foregroundColor(.secondary)

            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.gray) // Adjust the color as needed
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden() // Hide the default label provided by the DatePicker
            }
        }
        .padding(.horizontal)
    }
}
struct SelectGroupView: View {
    @State private var selectedGroup: MemberGroup?
    @Query private var groups: [MemberGroup]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
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
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .padding(.horizontal, 1)
        }
        .padding(.horizontal)
    }
}

struct AddAmountView: View {
    @Binding var selectedCategory: SelectedSectionName
    @State private var billAmount: String = ""
    @State private var expenseTitle: String = ""
    @State private var paymentDate: Date = Date()
    @State private var selectedGroup: MemberGroup? = nil
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    BillAmountSection(billAmount: $billAmount)
                    ExpenseTitleSection(expenseTitle: $expenseTitle)
                    PaymentDateGroupSection(paymentDate: $paymentDate, selectedGroup: $selectedGroup)
                    CategorySection()
                }

                Button("Next") {
                    withAnimation {
                        selectedCategory = .whoPaid
                    }
                    print("press the save button")
                    let newActivity = Activity(title: "TTTT", date: Date(), groupName: "Group name", amount: 1185.10)
                    modelContext.insert(newActivity)
                    print("should add a new activity")
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
