//
//  ForWhoView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI
import SwiftData

struct ForWhoTitleSection: View {
    @Binding var expenseAmount: Double

    var body: some View {
        HStack {
            // Bill amount
            Text(expenseAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.custom("Poppins", size: 25))
                .fontWeight(.regular)
                .lineSpacing(3.2)
        }
        .padding(.horizontal)
    }
}

struct ForWhoSection: View {
    let sampleGroupMembers: [String]
    @Binding var expenseAmount: Double
    @State private var selectedMembers: Set<String> = []
    @State private var amountPerPerson: Double = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("For Who?")
                .font(.custom("Poppins", size: 20))
                .foregroundColor(.secondary)
                .fontWeight(.regular)

            ForEach(sampleGroupMembers, id: \.self) { member in
                HStack {
                    Toggle(isOn: self.binding(for: member)) {
                        Text(member)
                            .font(.system(size: 16))
                    }
                    .toggleStyle(CheckboxToggleStyle())

                    Spacer()

                    if selectedMembers.contains(member) {
                        let currencyCode = Locale.current.currency?.identifier ?? "USD"
                        Text(amountPerPerson, format: .currency(code: currencyCode))
                            .frame(minWidth: 80, alignment: .trailing)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .padding(.horizontal)
        .onChange(of: selectedMembers) {
            updateAmountPerPerson()
        }
    }

    private func binding(for member: String) -> Binding<Bool> {
        Binding(
            get: { self.selectedMembers.contains(member) },
            set: { isSelected in
                if isSelected {
                    self.selectedMembers.insert(member)
                } else {
                    self.selectedMembers.remove(member)
                }
                updateAmountPerPerson()
            }
        )
    }

    private func updateAmountPerPerson() {
        let count = Double(selectedMembers.count)
        amountPerPerson = count > 0 ? expenseAmount / count : 0
    }
}

struct ForWhoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let sampleGroupMembers = ["Nadila Aulia (me)", "Amy", "Bob", "Charles", "David", "Eason", "Frank"]
    @Binding var expenseAmount: Double
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForWhoTitleSection(expenseAmount: $expenseAmount)
                    ForWhoSection(sampleGroupMembers: sampleGroupMembers, expenseAmount: $expenseAmount)
                }
                
                Button("Save") {
                    // TODO: save the expense
                    
                }
                .buttonStyle(FilledButton())
                .padding()
            }
        }
        .navigationTitle("Add New Expense")
    }
}
