import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddDebtView: View {
    let onAdd: (Debt) -> Void
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var totalAmount: String = ""
    @State private var amountPaid: String = ""
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Debt Details")) {
                    TextField("Debt Name", text: $name)
                    
                    TextField("Total Amount", text: $totalAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Amount Paid", text: $amountPaid)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Debt")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveDebt()
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
    
    func saveDebt() {
        guard let user = Auth.auth().currentUser else {
            print("User not logged in")
            return
        }
        
        let debt = Debt(
            id: UUID().uuidString,
            name: name,
            totalAmount: Double(totalAmount) ?? 0.0,
            amountPaid: Double(amountPaid) ?? 0.0
        )
        
        let debtData: [String: Any] = [
            "name": debt.name,
            "totalAmount": debt.totalAmount,
            "amountPaid": debt.amountPaid
        ]
        
        Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .collection("debts")
            .document(debt.id)
            .setData(debtData) { error in
                if let error = error {
                    print("❌ Failed to save debt: \(error.localizedDescription)")
                } else {
                    dismiss()
                }
            }
    }
}
