//
//  ContentView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    let customUIBlue = UIColor(red: 35 / 255, green: 96 / 255, blue: 250 / 255, alpha: 1)
    init() {
        // Customize the appearance of the tab bar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = customUIBlue
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: customUIBlue]
        
        // Set both the standard appearance and the scroll edge appearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
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
