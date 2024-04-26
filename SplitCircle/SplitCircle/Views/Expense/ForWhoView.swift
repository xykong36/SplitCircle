//
//  ForWhoView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI

struct ForWhoTitleSection: View {
    @Binding var billAmount: Double

    var body: some View {
        HStack {
            // Bill amount
            Text(billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.custom("Poppins", size: 25))
                .fontWeight(.regular)
                .lineSpacing(3.2)
        }
        .padding(.horizontal)
    }
}

struct ForWhoSection: View {
    let sampleGroupMembers: [String]
    @Binding var billAmount: Double
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
        amountPerPerson = count > 0 ? billAmount / count : 0
    }
}

struct ForWhoView: View {
    let sampleGroupMembers = ["Nadila Aulia (me)", "Amy", "Bob", "Charles", "David", "Eason", "Frank"]
    @State private var billAmount: Double = 100.00
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForWhoTitleSection(billAmount: $billAmount)
                    ForWhoSection(sampleGroupMembers: sampleGroupMembers, billAmount: $billAmount)
                }
                
                Button("Next") {
                    // Handle the next button action
                }
                .buttonStyle(FilledButton())
                .padding()
            }
        }
        .navigationTitle("Add New Expense")
    }
}

#Preview {
    ForWhoView()
}
