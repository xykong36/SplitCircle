//
//  Payee.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import Foundation
import SwiftData

@Model
final class Payee {
    @Attribute(.unique) var id: String
    var name: String
    var amount: Double
    
    
    init(id: String, name: String, share: Double) {
        self.id = id
        self.name = name
        self.amount = share
    }
}
