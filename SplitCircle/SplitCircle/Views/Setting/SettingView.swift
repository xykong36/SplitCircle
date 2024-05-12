//
//  SettingView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/17/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {

            Text("Nadila Aulia") // Replace with your dynamic name
                .font(.title2)
                .fontWeight(.medium)
                .padding(.top, 10)

            List {
                ProfileRow(iconName: "bell.fill", rowTitle: "Notifications Setting")
                ProfileRow(iconName: "bubble.left.and.bubble.right.fill", rowTitle: "Feedback")
            }
            .listStyle(InsetGroupedListStyle())

            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileRow: View {
    var iconName: String
    var rowTitle: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.accentColor)
                .imageScale(.large)
            Text(rowTitle)
                .fontWeight(.medium)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
}

#Preview {
    SettingView()
}
