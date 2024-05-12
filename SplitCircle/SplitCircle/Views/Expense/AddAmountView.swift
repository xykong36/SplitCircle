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
                .padding(.horizontal, 1)
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
            .padding(.horizontal, 1)
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
                .lineSpacing(3.2)
            
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

struct CategorySection: View {
    @State private var selectedCategory: Int?
    // Define the layout for your grid
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let categoryText = ["Bills", "Shopping", "Lodging", "Housing", "Entertainment", "Dining", "Grocery", "Transport", "Tickets", "Travel", "Others"]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Category")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular) // 'regular' is equivalent to weight 400
                .foregroundColor(.secondary)
                .lineSpacing(3.2)
            LazyVGrid(columns: layout, spacing: 20) {
                ForEach(0..<categoryText.count, id: \.self) { index in
                    Button(action: {
                        // Action when a category is tapped
                        selectedCategory = index
                    }) {
                        VStack {
                            Image(generateImageName(for: index, selected: selectedCategory == index))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50) // Adjust the size as needed
                            Text(categoryText[index])
                                .font(.caption)
                        }
                    }
                    .frame(width: 80, height: 75) // Adjust the frame as needed
                    .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal)
    }

    // Helper function to generate image name based on category text
    private func generateImageName(for index: Int, selected: Bool) -> String {
        let baseName = categoryText[index]
        let suffix = selected ? "Square44x44" : "Clear44x44"
        return "\(baseName)\(suffix)"
    }
}

struct AddAmountView: View {
    @Binding var selectedCategory: ExpenseCategory
    @State private var billAmount: String = ""
    @State private var expenseTitle: String = ""
    @State private var paymentDate: Date = Date()
    @State private var selectedGroup: MemberGroup? = nil

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
