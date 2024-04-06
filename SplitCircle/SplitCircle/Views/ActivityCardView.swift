//
//  ActivityCardView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftUI

struct ActivityCardView: View {
    var title: String = "Expense name"
    var date: Date = Date() 
    var groupName: String = "Group name"
    var amount: Double = 17.67
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
    
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white)
            .frame(height: 85)
            .shadow(radius: 2)
            .padding(12)
            .overlay(
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .stroke(Color.purple, lineWidth: 3)
                        Image("Entertainment")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(10)
                    }
                    .frame(width: 20, height: 20)
                    .padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 15))
                    
                
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(.headline)
                        HStack(spacing: 10) {
                            Text(dateFormatter.string(from: date))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(groupName)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    Text(currencyFormatter.string(from: NSNumber(value: amount)) ?? "")
                        .fontWeight(.bold)
                        .padding(10)
                }
                    .padding(.horizontal, 12)
            )
    }
}


#Preview {
    ActivityCardView()
}
