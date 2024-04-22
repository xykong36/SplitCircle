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
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            AddExpenseView()
                .tabItem {
                    Label("", image: "Green_Group")
                }

            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gearshape.fill")
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
