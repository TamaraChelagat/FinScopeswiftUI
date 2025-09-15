//
//  AddSavingsView.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 23/06/2025.
//

// UpdateSavingsView.swift

import SwiftUI

struct UpdateSavingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var savingsGoal: Double
    @Binding var savingsSoFar: Double

    @State private var newGoal = ""
    @State private var newSavings = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("New Goal", text: $newGoal)
                    .keyboardType(.decimalPad)
                TextField("New Savings", text: $newSavings)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Savings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let goal = Double(newGoal) {
                            savingsGoal = goal
                        }
                        if let savings = Double(newSavings) {
                            savingsSoFar = savings
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    UpdateSavingsView(savingsGoal: .constant(10000), savingsSoFar: .constant(2000))
}



