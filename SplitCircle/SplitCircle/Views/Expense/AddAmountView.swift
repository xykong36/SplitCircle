//
//  AddAmountView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI

struct BillAmountSection: View {
    @Binding var billAmount: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bill Amount")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular) // 'regular' is equivalent to weight 400
                .foregroundColor(.secondary)
                .lineSpacing(3.2)
            HStack {
                Image("dollar_sign")
                
                TextField("Enter total bill amount", text: $billAmount)
                    .keyboardType(.decimalPad)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 1)
        }
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
                .padding(.horizontal, 1)
        }
    }
}

struct PaymentDateGroupSection: View {
    @Binding var paymentDate: Date
    @Binding var selectedGroup: String?
    let groups: [String] // This would be your list of group names

    var body: some View {
        HStack {
            PaymentDateView()
            SelectGroupView()
        }
    }
}

struct CategorySection: View {
    var body: some View {
        Text("Category Section")
    }
}

struct PaymentDateView: View {
    @State private var selectedDate = Date() // Default to current date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Payment Date")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular) // 'regular' is equivalent to weight 400
                .foregroundColor(.secondary)
                .lineSpacing(3.2)
            
            HStack {
                Image("calendar_icon")
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden() // Hides the label to only show the date picker
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct SelectGroupView: View {
    @State private var selectedGroup: String?
    let groups = ["Group 1", "Group 2", "Group 3"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Group")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular) // 'regular' is equivalent to weight 400
                .foregroundColor(.secondary)
                .lineSpacing(3.2)
            
            Menu {
                ForEach(groups, id: \.self) { group in
                    Button(group) {
                        selectedGroup = group
                    }
                }
            } label: {
                HStack {
                    Text(selectedGroup ?? "Select group")
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

var categories: [(name: String, image: String)] = [
    ("Bills", "Bills"),
    ("Shopping", "Shopping"),
    ("Lodging", "Lodging"),
    ("Entertainment", "Entertainment"),
    ("Dinning", "Dinning"),
    ("Transportation", "Transportation"),
    ("Tickets", "Tickets"),
    ("Others", "Others")
]

struct AddAmountView: View {
    @State private var billAmount: String = ""
    @State private var expenseTitle: String = ""
    @State private var navigateToWhoPaid = false
    @State private var paymentDate: Date = Date()
    @State private var selectedGroup: String? = nil
    let groups = ["Group1", "Group2", "Group3"]
    
    var body: some View {
        VStack {
            Form {
                BillAmountSection(billAmount: $billAmount)
                ExpenseTitleSection(expenseTitle: $expenseTitle)
                PaymentDateGroupSection(paymentDate: $paymentDate, selectedGroup: $selectedGroup, groups: groups)
                CategorySection()
                
            }

            Button("Next") {
                // Handle the next button action
            }
            .buttonStyle(FilledButton())
            .padding()
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

#Preview {
    AddAmountView()
}
