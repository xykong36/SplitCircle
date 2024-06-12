//
//  SettingView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/17/24.
//

import SwiftUI
import SwiftData

struct SettingView: View {
    @State private var name: String = "Nadila Aulia"
    @State private var showingEditName = false
    @Query private var users: [User]
    
    var body: some View {
        // Find the user where isCurrentUser is true
        var currentUser: User? {
            users.first { $0.isCurrentUser == true }
        }
        NavigationView {
            VStack {
                HStack {
                    if let user = currentUser {
                        Text(user.name)
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.top, 10)
                    } else {
                        Text("Your Username")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.top, 10)
                    }
                    Spacer()
                    Button(action: {
                        showingEditName = true
                    }) {
                        Image(systemName: "pencil")
                            .imageScale(.medium)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
                
                List {
                    ProfileRow(iconName: "bell.fill", rowTitle: "Notifications Setting")
                    ProfileRow(iconName: "bubble.left.and.bubble.right.fill", rowTitle: "Feedback")
                }
                .listStyle(InsetGroupedListStyle())
                
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingEditName) {
                NavigationStack {
                    Form {
                        TextField("Name", text: $name)
                            .padding()
                            .navigationTitle("Edit Name")
                            .navigationBarItems(leading: Button("Cancel") {
                                showingEditName = false
                            }, trailing: Button("Save") {
                                
                                showingEditName = false
                            })
                    }
                }
            }
        }
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

