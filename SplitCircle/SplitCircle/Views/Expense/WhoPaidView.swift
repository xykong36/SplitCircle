//
//  WhoPaidView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI


struct WhoPaidView: View {
    @Binding var selectedCategory: SelectedSectionName
    @Binding var expenseAmount: Double
    @Binding var expenseGroup: MemberGroup
    @Binding var expensePayers: [User]

    var payerSplitAmount: Double {
        guard !expensePayers.isEmpty else { return 0 }
        return expenseAmount / Double(expensePayers.count)
    }

    var body: some View {
        VStack {
            AmountTitleSection(expenseAmount: $expenseAmount)
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Who Paid?")
                        .font(.custom("Poppins", size: 20))
                        .foregroundColor(.secondary)
                        .fontWeight(.regular)
                        .padding(.leading, 20)
                    MembersToggleSection(members: $expenseGroup.members, selectedMembers: $expensePayers, splitAmount: payerSplitAmount)
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
