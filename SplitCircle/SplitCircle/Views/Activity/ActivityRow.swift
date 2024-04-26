//
//  ActivityRow.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftUI

struct ActivityRow: View {
    var activity: Activity
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
            .overlay(
                HStack(spacing: 3) {
                    ImageIconView(imageName: "BillsRound40x40")
                    VStack(alignment: .leading, spacing: 4) {
                        Text(activity.title)
                            .font(.headline)
                            .padding(.vertical, 3)
                        HStack(spacing: 8) {
                            Text(dateFormatter.string(from: activity.date))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(activity.groupName)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    if let amountString = currencyFormatter.string(from: NSNumber(value: activity.amount)) {
                        Text(amountString)
                            .kerning(0.2)
                            .frame(minWidth: 20, maxWidth: 100, alignment: .trailing)
                            .fontWeight(.bold)
                            .font(.body)
                    }
                }
            )
    }
}

private struct ImageIconView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .padding(EdgeInsets(top: 30, leading: 5, bottom: 25, trailing: 10))
    }
}
