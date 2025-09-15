//
//  Debt.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 30/06/2025.
//

// Debt.swift

import Foundation

struct Debt: Identifiable {
    let id: String
    var name: String
    var totalAmount: Double
    var amountPaid: Double

    var progress: Double {
           let rawProgress = totalAmount > 0 ? amountPaid / totalAmount : 0
           return min(max(rawProgress, 0), 1)
       }
}

