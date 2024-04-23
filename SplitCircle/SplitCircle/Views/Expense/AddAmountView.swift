//
//  AddAmountView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI

struct BillAmountSection: View {
    var body: some View {
        Text("Bill Amount Section")
    }
}

struct ExpenseTitleSection: View {
    var body: some View {
        Text("Expense Title Section")
    }
}

struct PaymentDateGroupSection: View {
    
    var body: some View {
        Text("Payment Date & Group Section")
    }
}

struct CategorySection: View {
    var body: some View {
        Text("Category Section")
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
    @State private var paymentDate = Date()
    @State private var selectedGroup: String?
    @State private var navigateToWhoPaid = false
    
    var body: some View {
        VStack {
            Form {
                BillAmountSection()
                ExpenseTitleSection()
                PaymentDateGroupSection()
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
