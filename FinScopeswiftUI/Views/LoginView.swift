import SwiftUI
import FirebaseFirestore

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var navigate = false
    @State private var errorMessage = ""
    @State private var showingLoginError = false
    @State private var loginErrorMessage: String? = nil
// self.fetchDebts()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 123/255, green: 44/255, blue: 191/255),    // Purple
                        Color(red: 244/255, green: 166/255, blue: 152/255)    // Soft Peach
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer()
                            .frame(height: 60)

                        Text("Log In")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)

                        // Email
                        textField("Email", text: $email, keyboardType: .emailAddress)

                        // Password
                        secureField("Password", text: $password)

                        HStack {
                            Spacer()
                            Button("Forgot Password?") {
                                // optional logic here
                            }
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.9))
                        }

                        Button(action: {
                            authVM.signIn(email: email, password: password) { success, error in
                                if success {
                                    authVM.fetchDebts()
                                    navigate = true
                                } else {
                                    loginErrorMessage = error ?? "Login failed."
                                    showingLoginError = true
                                }
                            }
                        }) {
                            Text("Log In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                        }
                        .padding(.top, 10)

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .alert("Login Error", isPresented: $showingLoginError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(loginErrorMessage ?? "An unknown error occurred.")
            }
            .navigationDestination(isPresented: $navigate) {
                MainTabView()
            }
        }
    }

    // MARK: - Styled Text Fields

    @ViewBuilder
    func textField(_ placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType = .default) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .foregroundColor(.white)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }

    @ViewBuilder
    func secureField(_ placeholder: String, text: Binding<String>) -> some View {
        SecureField(placeholder, text: text)
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
