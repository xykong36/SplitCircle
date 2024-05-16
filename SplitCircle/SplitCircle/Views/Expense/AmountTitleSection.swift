//
//  AmountTitleSection.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 5/16/24.
//

import SwiftUI

struct AmountTitleSection: View {
    @Binding var expenseAmount: Double

    var body: some View {
        HStack {
            Text(expenseAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.custom("Poppins", size: 25))
                .fontWeight(.regular)
                .lineSpacing(3.2)
        }
        .padding(.horizontal)
    }
}
