//
//  ContentView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: Alignment.bottom) {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                            .padding(.leading)
                    }
//                AddExpenseView()
//                    .tabItem {
//                        Label("Add", systemImage: "plus.circle.fill")
//                    }
                Spacer()
                SettingView()
                    .tabItem {
                        Label("Setting", systemImage: "gearshape.fill")
                            .padding(.horizontal)
                    }
            }
            Text("Button")
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
