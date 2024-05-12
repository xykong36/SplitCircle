//
//  WhoPaidView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI

struct WhoPaidTitleSection: View {
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

struct WhoPaidSection: View {
    let sampleGroupMembers: [String]
    @Binding var billAmount: Double
    @State private var selectedMembers: Set<String> = []
    @State private var amountPerPerson: Double = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Who paid?")
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


// Custom ToggleStyle to mimic a checkbox
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}

struct WhoPaidView: View {
    @Binding var selectedCategory: ExpenseCategory
    let sampleGroupMembers = ["Nadila Aulia (me)", "Amy", "Bob", "Charles", "David", "Eason", "Frank"]
    @State private var billAmount: Double = 100.00
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    WhoPaidTitleSection(billAmount: $billAmount)
                    WhoPaidSection(sampleGroupMembers: sampleGroupMembers, billAmount: $billAmount)
                }
                
                Button("Next") {
                    withAnimation {
                        selectedCategory = .forWho
                    }
                }
                .buttonStyle(FilledButton())
                .padding()
            }
        }
        .navigationTitle("Add New Expense")
    }
}
