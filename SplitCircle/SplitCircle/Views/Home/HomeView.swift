//
//  HomeView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    
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
