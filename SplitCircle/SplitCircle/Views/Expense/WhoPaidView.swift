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
    @State private var selections: [Bool] = Array(repeating: false, count: 10)

    @State private var amountPerPerson: Double = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Who paid?")
                .font(.custom("Poppins", size: 20))
                .foregroundColor(.secondary)
                .fontWeight(.regular)
            
            ForEach(0..<expenseGroup.members.count, id: \.self) { index in
                Toggle(isOn: $selections[index]) {
                    Text(expenseGroup.members[index].name)
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.vertical, 2)
            }
            
            Text("Selected Options:")
                .font(.headline)
                .padding(.top)
            
            ForEach(selectedOptions, id: \.id) { option in
                Text(option.name)
            }
        }
        .padding(.horizontal)
    }

    // 计算属性：选中的选项
    var selectedOptions: [User] {
        expenseGroup.members.enumerated().compactMap { index, member in
            selections[index] ? member : nil
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
    @Binding var expensePayees: [User]
    
    
    var memberNames: [String] {
        expenseGroup.members.map { $0.name }
    }
    var body: some View {
        VStack {
            WhoPaidTitleSection(expenseAmount: $expenseAmount)
            ScrollView {
                VStack(spacing: 15) {
                    
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
