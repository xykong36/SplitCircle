//
//  CategorySection.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 5/12/24.
//

import SwiftUI

struct CategorySection: View {
    @State private var selectedCategory: ExpenseCategory?

    static let layout = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack(alignment: .leading) {
            Text("Expense Category")
                .font(.custom("Poppins", size: 16))
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .lineSpacing(3.2)

            LazyVGrid(columns: CategorySection.layout, spacing: 5) {
                ForEach(ExpenseCategory.allCases, id: \.self) { category in
                    CategoryButton(category: category, selected: $selectedCategory)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CategoryButton: View {
    let category: ExpenseCategory
    @Binding var selected: ExpenseCategory?

    var body: some View {
        Button(action: {
            selected = category
        }) {
            VStack {
                Image(category.imageName(selected: selected == category))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(category.rawValue)
                    .font(.subheadline)
                    .fontWeight(selected == category ? .bold : .regular)
            }
        }
        .frame(width: 80, height: 75)
        .cornerRadius(10)
    }
}

enum ExpenseCategory: String, CaseIterable {
    case bills = "Bills"
    case shopping = "Shopping"
    case lodging = "Lodging"
    case tickets = "Tickets"
    case dining = "Dining"
    case grocery = "Grocery"
    case travel = "Travel"
    case others = "Others"

    // Helper function to generate image name based on whether the category is selected
    func imageName(selected: Bool) -> String {
        let suffix = selected ? "Square44x44" : "Clear44x44"
        return "\(rawValue)\(suffix)"
    }
}

#Preview {
    CategorySection()
}
