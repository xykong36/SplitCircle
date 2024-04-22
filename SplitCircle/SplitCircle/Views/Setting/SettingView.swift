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
            ZStack {
                Circle()
                    .strokeBorder(Color.gray, lineWidth: 4)
                    .background(Circle().foregroundColor(Color.white))
                    .overlay(
                        Image("profilePicture") // Replace with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    )
                    .frame(width: 120, height: 120)
                    .shadow(radius: 10)

                Circle()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.blue)
                    .overlay(
                        Text("2")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    )
                    .offset(x: 40, y: 40)
            }
            .padding(.top, 20)

            Text("Nadila Aulia") // Replace with your dynamic name
                .font(.title2)
                .fontWeight(.medium)
                .padding(.top, 10)

            Text("[email address]") // Replace with your dynamic email
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.top, 2)

            List {
                ProfileRow(iconName: "person.fill", rowTitle: "Personal Information")
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
