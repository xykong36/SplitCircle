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
            ScrollView {
                // Balance Card
                NavigationLink {
                    MyDebtsView()
                } label: {
                    DebtsCardView().padding()
                }
            }
            // Group Section
            GroupsTitleView()
            GroupsView()

            // Activities Section
            ActivitiesTitleView()
            ActivitiesView()
        }
    }
}

// Define a destination view for the navigation link
struct ActivityDetailView: View {
    var body: some View {
        Text("Expense name")
    }
}

// Define a destination view for the navigation link
struct AllActivitiesView: View {
    var body: some View {
        Text("All Activities")
    }
}

#Preview("Try HomeView") {
    HomeView()
        .modelContainer(previewContainer)
}
