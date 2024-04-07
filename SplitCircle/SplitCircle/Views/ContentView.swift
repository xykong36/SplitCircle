//
//  ContentView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        Text("User at \(user.email)")
                    } label: {
                        Text("hi")
                        Text(user.name)
                    }
                }
                .onDelete(perform: deleteUsers)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addUser) {
                        Label("Add User", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addUser() {
        withAnimation {
            let newUser = User(id: UUID().uuidString, email: "test@g.com", name: "xiangyu")
            modelContext.insert(newUser)
        }
    }

    private func deleteUsers(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(users[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
