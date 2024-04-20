//
//  ActivitiesView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import SwiftUI

// Custom navigation bar title view with integrated "View all" button
struct ActivitiesTitleView: View {
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
                ActivityDetailView()
            } label: {
                ActivityRow(activity: activity)
            }
            .frame(height: 45)
            .padding(.vertical, 3)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ActivitiesView()
}
