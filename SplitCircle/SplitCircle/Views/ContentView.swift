//
//  ContentView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showAddExpense = false

    var body: some View {
        ZStack(alignment: Alignment.bottom) {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                SettingView()
                    .tabItem {
                        Label("Setting", systemImage: "gearshape.fill")
                            .padding(.horizontal)
                    }
            }
            
            Button(action: {
                showAddExpense.toggle()
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                    )
            }
            .offset(y: -10)
            .fullScreenCover(isPresented: $showAddExpense) {
                AddExpenseView(isPresented: $showAddExpense)
            }
        }
    }
}

private struct TabImageView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 5, height: 5)
    }
}

#Preview {
    ContentView()
}
