//
//  MyDebtsView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/19/24.
//

import SwiftUI

struct MyDebtsView: View {
        
    // Sample transactions data
    @State private var transactions: [DebtTransaction] = [
        DebtTransaction(name: "Alice", amount: 17.67, isSettled: false),
        DebtTransaction(name: "Bob", amount: -33.00, isSettled: false),
        DebtTransaction(name: "Charlie", amount: -127.50, isSettled: false),
        DebtTransaction(name: "Diana", amount: 0.00, isSettled: true)
    ]
    @State private var showingSettled: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var filteredTransactions: [DebtTransaction] {
        transactions.filter { $0.isSettled == showingSettled }
    }
    
    var totalOwed: Double {
        // Compute the total amount owed
        transactions.filter { !$0.isSettled }.reduce(0) { $0 + $1.amount }
    }
    
//    init() {
//        // Customizing navigation bar appearance
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        let customBlueUIColor = UIColor(red: 35 / 255, green: 96 / 255, blue: 250 / 255, alpha: 1)
//        appearance.backgroundColor = customBlueUIColor
//        
//        // Assigning custom appearance to navigation bar
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
//    var backButton: some View {
//        Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            Image("Back_Arrow")
//        }
//    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Header with image and total amount owed
                VStack {
                    Image("Debts_Dollar_Sign")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("You owed:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("$\(totalOwed, specifier: "%.2f")")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                
                // Toggle for Unsettled and Settled
                HStack {
                    CustomToggleStyle(isSettled: $showingSettled, width: geometry.size.width - 32)
                }
                .padding()

                // Transactions List
                List {
                    ForEach(filteredTransactions) { transaction in
                        DebtTransactionRow(transaction: transaction)
                    }
                }
            }
        }
        .navigationTitle("Debts")
        
    }
}

struct CustomToggleStyle: View {
    @Binding var isSettled: Bool
    let width: CGFloat // Width of the toggle, will be provided by parent view

    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.gray.opacity(0.2))
                .frame(width: width, height: 50)
            
            // Highlighted background that moves
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.blue)
                .frame(width: width / 2, height: 48) // Half the width of the toggle
                .offset(x: isSettled ? width / 4 : -width / 4)
                .animation(.easeInOut, value: isSettled)
            
            // Text
            HStack {
                Button("Unsettled") {
                    withAnimation { isSettled = false }
                }
                .frame(width: width / 2) // Half the width of the toggle

                Button("Settled") {
                    withAnimation { isSettled = true }
                }
                .frame(width: width / 2) // Half the width of the toggle
            }
            .font(.headline.bold())
            .foregroundColor(.white)
        }
        .frame(width: width, height: 36) // Set the height of the entire component
    }
}

// Row view for each debt transaction
struct DebtTransactionRow: View {
    let transaction: DebtTransaction

    var body: some View {
        HStack {
            Text(transaction.name)
                .font(.headline)
                .padding(.vertical, 15)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text(transaction.amountText)
                .font(.headline) // Optional: Adjust font size if needed
                .fontWeight(.bold) // Make the amount text bold
                .padding(.vertical, 8) // Add more padding to make the row thicker
                .foregroundColor(transaction.amount > 0 ? .green : (transaction.amount == 0 ? .black : .red))
        }
        .padding(.horizontal) // Add padding on the sides if needed
        .background(Color.white) // Set a background color if needed
        .cornerRadius(10) // Round the corners
    }

}

// A mock model to represent a debt transaction
struct DebtTransaction: Identifiable {
    let id = UUID()
    var name: String
    var amount: Double
    var isSettled: Bool
    
    var amountText: String {
        let sign = amount > 0 ? "+" : ""
        return "\(sign)\(amount) USD"
    }
}

#Preview {
    MyDebtsView()
}
