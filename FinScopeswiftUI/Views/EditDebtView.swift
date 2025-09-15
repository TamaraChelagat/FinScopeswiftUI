import SwiftUI
import FirebaseAuth

struct EditDebtView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var newPayment: String = ""
    @Binding var debt: Debt
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Update Payment")) {
                    Text("Debt: \(debt.name)")
                    Text("Paid: \(debt.amountPaid, specifier: "%.2f") of \(debt.totalAmount, specifier: "%.2f")")
                    
                    TextField("Enter additional payment", text: $newPayment)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("Delete Debt", role: .destructive) {
                        authVM.deleteDebt(debt)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit Debt")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let addedAmount = Double(newPayment) {
                            debt.amountPaid += addedAmount
                            authVM.saveDebt(debt) // ← update Firestore too
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
