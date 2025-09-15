//
//  EditSavingsView.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 01/07/2025.
//

import Foundation
import SwiftUI

struct EditSavingsView: View {
    @Binding var savingsGoal: Double
    @Binding var savingsSoFar: Double
    @Environment(\.dismiss) var dismiss

    @State private var newGoal = ""
    @State private var additionalSavings = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Update Savings Goal")) {
                    TextField("New goal", text: $newGoal)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Add Savings")) {
                    TextField("Add amount", text: $additionalSavings)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Edit Savings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let goal = Double(newGoal), goal > 0 {
                            savingsGoal = goal
                        }
                        if let add = Double(additionalSavings) {
                            savingsSoFar += add
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
