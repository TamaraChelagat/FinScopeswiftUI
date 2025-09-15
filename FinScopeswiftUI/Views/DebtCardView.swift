//
//  DebtCardView.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 30/06/2025.
//

import Foundation
import SwiftUI

struct DebtCardView: View {
    let debt: Debt

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(debt.name)
                    .font(.headline)
                Spacer()
                Text("Ksh \(Int(debt.amountPaid)) / \(Int(debt.totalAmount))")
                    .font(.subheadline)
            }
            ProgressView(value: min(max(debt.progress, 0), 1))
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
            
            Text(String(format: "%.0f%% paid", debt.progress * 100))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}



