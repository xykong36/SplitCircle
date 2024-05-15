//
//  WhoPaidView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI

struct WhoPaidTitleSection: View {
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

struct WhoPaidSection: View {
    @Binding var expenseAmount: Double
    @Binding var expenseGroup: MemberGroup
    @State private var selectedMembers: Set<String> = []
    @State private var amountPerPerson: Double = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Who paid?")
                .font(.custom("Poppins", size: 20))
                .foregroundColor(.secondary)
                .fontWeight(.regular)
            
            Text(expenseGroup.name)

            ForEach(expenseGroup.members.map { $0.name }, id: \.self) { member in
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
    @Binding var selectedCategory: SelectedSectionName
    @Binding var expenseAmount: Double
    @Binding var expenseGroup: MemberGroup
    var memberNames: [String] {
        expenseGroup.members.map { $0.name }
    }
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    WhoPaidTitleSection(expenseAmount: $expenseAmount)
                    WhoPaidSection(expenseAmount: $expenseAmount, expenseGroup: $expenseGroup)
                }
                Button("Next") {
                    print("expenseAmount now: \(expenseAmount)")
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
