//
//  HomeView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext

    // Function to check if there exists a user with isCurrentUser == true
    func isCurrentUserExists() -> Bool {
        return users.contains(where: { $0.isCurrentUser })
    }
    var body: some View {
        NavigationStack {

            // Balance Section
            BalanceView()
            
            // Group Section
            GroupsTitleView()
            GroupsView()

            // Expenses Section
            ExpensesTitleView()
            ExpensesView()
        }
    }
}
