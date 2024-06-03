//
//  HomeView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @State private var showingDebtsSheet = false

    var body: some View {
        NavigationStack {
            // Balance Card
            Button(action: {
                showingDebtsSheet = true
            }) {
                DebtsCardView().padding()
            }
            .sheet(isPresented: $showingDebtsSheet) {
                MyDebtsView()
            }

            // Group Section
            GroupsTitleView()
            GroupsView()

            // Expenses Section
            ExpensesTitleView()
            ExpensesView()
        }
    }
}
