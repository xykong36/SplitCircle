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
            BillCardView().padding(.vertical, 10)
            // Balance Card

            // Group Section
            GroupRow(groups: simpleMemberGroups)

            // Activities Section
            NavigationBarTitleView()
            ActivitiesView()
        }
    }
}

struct BillCardView: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .shadow(radius: 10)

            // Content
            VStack(alignment: .leading, spacing: 10) {
                Text("Hi, Nadila Aulia,")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text("you have unpaid bill")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.white)

                HStack {
                    Text("$156.98")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "calculator")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 48)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .frame(width: 350, height: 150)
        .padding()
    }
}

// Define a simple struct for an activity
struct Activity {
    var title: String
    var date: Date
    var groupName: String
    var amount: Double
}

// Define a destination view for the navigation link
struct ExpenseDetailView: View {
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

// Custom navigation bar title view with integrated "View all" button
struct NavigationBarTitleView: View {
    var body: some View {
        HStack {
            Text("Activities").font(.title).bold()
            Spacer()
            NavigationLink(destination: AllActivitiesView()) {
                Text("View all").foregroundColor(.accentColor)
            }
        }.padding(.horizontal)
    }
}

// Main view that includes the NavigationStack and List
struct ActivitiesView: View {
    var body: some View {
        List(activities, id: \.title) { activity in
            NavigationLink {
                ExpenseDetailView()
            } label: {
                ActivityRow(activity: activity)
            }
            .frame(height: 45)
            .padding(.vertical, 3)
        }
        .listStyle(.plain)
    }
}

#Preview("Try HomeView") {
    HomeView()
}

// private struct ActivitySection: View {
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Activities")
//                .font(.headline)
//                .padding(.leading)
//
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(spacing: 10) {
//                    ForEach(expenseViewModel.expenses.sorted { $0.timestamp > $1.timestamp }.prefix(3)) { expense in
//                        NavigationLink(destination: ExpenseDetailView(entry: expense)) {
//                            ActivityCardView(expense: expense)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//
//                    // "Show All" Button
//                    NavigationLink(destination: ActivityView(expenseViewModel: expenseViewModel)) {
//                        Text("Show All")
//                            .foregroundColor(.blue)
//                    }
//                    .padding(.top, 5)
//                }
//                .padding(.horizontal)
//            }
//            .frame(maxHeight: 400) // Set a max height for the scroll view
//        }
//    }
// }
