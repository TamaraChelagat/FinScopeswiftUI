import SwiftUI
import Charts
import FirebaseAuth
import Firebase

struct HomeDashboardView: View {
    @EnvironmentObject var authVM: AuthViewModel

    @State private var showingAddDebt = false
    @State private var selectedDebtIndex: String?
    @State private var isEditingDebt = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 30) {
                    
                    // MARK: - Centered Pie Chart
                    PieChart(debts: authVM.debts)
                        .frame(width: 200, height: 200)
                        .padding(.top, 20)

                    // MARK: - Tracked Debts
                    if authVM.debts.isEmpty {
                        Text("No debts tracked yet.")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Tracked Debts")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            ForEach(authVM.debts, id: \.id) { debt in
                                DebtCardView(debt: debt)
                                    .onTapGesture {
                                        if let index = authVM.debts.firstIndex(where: { $0.id == debt.id }) {
                                            selectedDebtIndex = debt.id
                                            isEditingDebt = true
                                        }
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Hello \(authVM.user?.firstName ?? ""),")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddDebt = true
                    } label: {
                        Label("Add Debt", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddDebt) {
                AddDebtView { newDebt in
                    authVM.saveDebt(newDebt)

                }
            }
            .sheet(isPresented: $isEditingDebt) {
                if let debtId = selectedDebtIndex,
                   let debtIndex = authVM.debts.firstIndex(where: { $0.id == debtId }) {
                    
                    EditDebtView(debt: Binding(
                        get: { authVM.debts[debtIndex] },
                        set: { authVM.debts[debtIndex] = $0 }
                    ))
                }
            }

        }
    }
}
