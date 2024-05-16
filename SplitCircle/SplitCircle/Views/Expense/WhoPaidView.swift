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
    @Binding var expensePayers: [User]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Who paid?")
                .font(.custom("Poppins", size: 20))
                .foregroundColor(.secondary)
                .fontWeight(.regular)
        
            ForEach(expenseGroup.members, id: \.id) { member in
                Toggle(isOn: Binding(
                    get: { expensePayers.contains { $0.id == member.id } },
                    set: { isSelected in
                        if isSelected {
                            expensePayers.append(member)
                        } else {
                            expensePayers.removeAll { $0.id == member.id }
                        }
                    }
                )) {
                    Text(member.name)
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.vertical, 2)
            }
        }
        .padding(.horizontal)
        
        Text("expenseGroup Name: ")
        Text(expenseGroup.name)
        Text("Payers: ")
        
        ForEach(expensePayers, id: \.id) { pp in
            Text(pp.name)
        }
    }
}


// Custom ToggleStyle to mimic a checkbox
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Button(action: {
                configuration.isOn.toggle()
            }) {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .font(.system(size: 20))
            }
            .buttonStyle(PlainButtonStyle())
            
            configuration.label
        }
    }
}

struct WhoPaidView: View {
    @Binding var selectedCategory: SelectedSectionName
    @Binding var expenseAmount: Double
    @Binding var expenseGroup: MemberGroup
    @Binding var expensePayers: [User]
    
    var body: some View {
        VStack {
            WhoPaidTitleSection(expenseAmount: $expenseAmount)
            ScrollView {
                VStack(spacing: 15) {
                    
                    WhoPaidSection(expenseAmount: $expenseAmount, expenseGroup: $expenseGroup, expensePayers: $expensePayers)
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
