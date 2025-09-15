import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var debts: [Debt] = []
    
    private var db = Firestore.firestore()
    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.isLoggedIn = false
                    completion(false, error.localizedDescription)
                    return
                }
                guard let user = result?.user else {
                    self.isLoggedIn = false
                    completion(false, "No user returned.")
                    return
                }
                self.fetchUserProfile(uid: user.uid)
                self.isLoggedIn = true
                completion(true, nil)
            }
        }
    }
    private var debtsListener: ListenerRegistration?

    func fetchDebts() {
        guard let user = Auth.auth().currentUser else {
            print("❌ User not logged in.")
            return
        }
        
        debtsListener?.remove()
        
        debtsListener = db.collection("users")
            .document(user.uid)
            .collection("debts")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("❌ Failed to fetch debts: \(error.localizedDescription)")
                    return
                }
                
                var fetchedDebts: [Debt] = []
                
                snapshot?.documents.forEach { doc in
                    let data = doc.data()
                    let debt = Debt(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "",
                        totalAmount: data["totalAmount"] as? Double ?? 0.0,
                        amountPaid: data["amountPaid"] as? Double ?? 0.0
                    )
                    fetchedDebts.append(debt)
                }
                
                DispatchQueue.main.async {
                    self.debts = fetchedDebts
                }
            }
    }


    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isLoggedIn = false
            
            debtsListener?.remove()
            debtsListener = nil
            
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    
    
    private func fetchUserProfile(uid: String) {
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                if let data = data,
                   let firstName = data["firstName"] as? String,
                   let secondName = data["secondName"] as? String,
                   let email = data["email"] as? String,
                   let phone = data["phone"] as? String,
                   let language = data["language"] as? String,
                   let dobTimestamp = data["dob"] as? Timestamp {
                    
                    let dob = dobTimestamp.dateValue()
                    
                    self.user = User(
                        id: uid,
                        firstName: firstName,
                        secondName: secondName,
                        email: email,
                        dob: dob,
                        phone: phone,
                        language: language
                    )
                }
            }
        }
    }
    
    func saveDebt(_ debt: Debt) {
        guard let user = Auth.auth().currentUser else { return }
        
        let data: [String: Any] = [
            "name": debt.name,
            "totalAmount": debt.totalAmount,
            "amountPaid": debt.amountPaid
        ]
        
        db.collection("users")
            .document(user.uid)
            .collection("debts")
            .document(debt.id)
            .setData(data) { error in
                if let error = error {
                    print("❌ Failed to save debt: \(error.localizedDescription)")
                } else {
                    print("✅ Debt saved!")
                    
                }
            }
    }



    func deleteDebt(_ debt: Debt) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection("users")
          .document(user.uid)
          .collection("debts")
          .document(debt.id)
          .delete { error in
              if let error = error {
                  print("❌ Error deleting debt: \(error.localizedDescription)")
              } else {
                  print("✅ Debt deleted.")
              }
          }
    }
    func updateDebt(_ debt: Debt) {
        guard let user = Auth.auth().currentUser else { return }
        
        let data: [String: Any] = [
            "name": debt.name,
            "totalAmount": debt.totalAmount,
            "amountPaid": debt.amountPaid
        ]

        db.collection("users")
          .document(user.uid)
          .collection("debts")
          .document(debt.id)  
          .setData(data, merge: true) { error in
              if let error = error {
                  print("🔥 Error updating debt: \(error.localizedDescription)")
              }
          }
    }




}
