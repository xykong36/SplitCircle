//
//  AddExpenseView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/17/24.
//

import SwiftUI

enum SelectedSectionName {
    case amount, whoPaid, forWho
}

struct AddExpenseView: View {
    @State private var currentSectionName: SelectedSectionName = .amount
    var body: some View {
        NavigationView {
            VStack {
                // This picker will function as your segmented control for switching views
                Picker("Category", selection: $currentSectionName) {
                    Text("Amount").tag(SelectedSectionName.amount)
                    Text("Who paid?").tag(SelectedSectionName.whoPaid)
                    Text("For who?").tag(SelectedSectionName.forWho)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // The content below the picker changes based on the selected category
                switch currentSectionName {
                case .amount:
                    AddAmountView(selectedCategory: $currentSectionName)
                case .whoPaid:
                    WhoPaidView(selectedCategory: $currentSectionName)
                case .forWho:
                    ForWhoView()
                }

                Spacer() // Pushes everything to the top
            }
            .navigationTitle("Add New Expense")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

#Preview {
    AddExpenseView()
}
