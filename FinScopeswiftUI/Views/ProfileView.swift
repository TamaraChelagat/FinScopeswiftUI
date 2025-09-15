import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var editing = false
    @State private var showLogoutAlert = false

    @State private var firstName = ""
    @State private var secondName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var language = ""

    var body: some View {
        ZStack {
            // 🌈 Warm purple-peach gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 123/255, green: 44/255, blue: 191/255),   // Purple
                    Color(red: 244/255, green: 166/255, blue: 152/255)   // Soft Peach
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .shadow(radius: 10)

                Text("\(firstName) \(secondName)")
                    .font(.title.bold())
                    .foregroundColor(.white)

                VStack(spacing: 16) {
                    profileField(title: "Email", value: $email, isEditing: editing)
                    profileField(title: "Phone", value: $phone, isEditing: editing)
                    profileField(title: "Language", value: $language, isEditing: editing)
                }
                .padding()
                .background(
                    Color.white.opacity(0.2)
                        .blur(radius: 10)
                        .background(.ultraThinMaterial)
                )
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 30)
                .animation(.easeInOut, value: editing)

                HStack(spacing: 20) {
                    Button(editing ? "Save" : "Edit") {
                        if editing {
                            saveProfileUpdates()
                        }
                        editing.toggle()
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(editing ? Color.green : Color.white.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)

                    Button("Log Out") {
                        showLogoutAlert = true
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 30)

                Spacer()
            }
            .padding(.top, 40)
        }
        .onAppear {
            loadProfile()
        }
        .alert("Log Out?", isPresented: $showLogoutAlert) {
            Button("Log Out", role: .destructive) {
                authVM.signOut()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to log out?")
        }
    }

    @ViewBuilder
    private func profileField(title: String, value: Binding<String>, isEditing: Bool) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))

            if isEditing {
                TextField(title, text: value)
                    .textFieldStyle(.roundedBorder)
            } else {
                Text(value.wrappedValue)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func loadProfile() {
        guard let user = authVM.user else { return }
        firstName = user.firstName
        secondName = user.secondName
        email = user.email
        phone = user.phone
        language = user.language
    }

    private func saveProfileUpdates() {
        guard let user = Auth.auth().currentUser else { return }

        let updatedData: [String: Any] = [
            "firstName": firstName,
            "secondName": secondName,
            "email": email,
            "phone": phone,
            "language": language
        ]

        let db = Firestore.firestore()
        db.collection("users").document(user.uid).updateData(updatedData) { error in
            if let error = error {
                print("⚠️ Failed to update user profile: \(error.localizedDescription)")
            } else {
                authVM.user?.firstName = firstName
                authVM.user?.secondName = secondName
                authVM.user?.email = email
                authVM.user?.phone = phone
                authVM.user?.language = language
                print("✅ Profile updated successfully.")
            }
        }
    }
}
