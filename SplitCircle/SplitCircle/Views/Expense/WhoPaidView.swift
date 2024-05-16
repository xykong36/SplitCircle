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

    var body: some View {
        VStack {
            AmountTitleSection(expenseAmount: $expenseAmount)
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Who Paid?")
                        .font(.custom("Poppins", size: 20))
                        .foregroundColor(.secondary)
                        .fontWeight(.regular)
                    MembersToggleSection(members: $expenseGroup.members, selectedMembers: $expensePayers)
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
