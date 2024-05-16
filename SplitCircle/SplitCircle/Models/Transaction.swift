//
//  Transaction.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 5/15/24.
//

import Foundation
import SwiftData

@Model
final class Transaction {
    @Attribute(.unique) var id: UUID
    var name: String
    var payer: User
    var payee: User
    var amount: Double
    var transactionDate: Date
    var isSettled: Bool
    var settledDate: Date?

    init(id: UUID, name: String, payer: User, payee: User, amount: Double, transactionDate: Date, isSettled: Bool, settledDate: Date? = nil) {
        self.id = id
        self.name = name
        self.payer = payer
        self.payee = payee
        self.amount = amount
        self.transactionDate = transactionDate
        self.isSettled = isSettled
        self.settledDate = settledDate
    }
}
