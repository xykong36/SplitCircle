//
//  HomeView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    var body: some View {
        
        VStack{
            Text("Hello, World!")
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            ActivitySection()
        }
    }
}

//private struct ActivitySection: View {
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
//}


#Preview {
    HomeView()
}
