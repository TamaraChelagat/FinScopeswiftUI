import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var firstName = ""
    @State private var secondName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var dateOfBirth = Date()
    @State private var phoneNumber = ""
    @State private var selectedLanguage = "English"
    @State private var errorMessage = ""
    @State private var isSignedUp = false
    @State private var showConfirmation = false
    @State private var showingErrorAlert = false

    let popularLanguages = [
        "English", "Spanish", "French", "Swahili", "Arabic",
        "Mandarin Chinese", "Hindi", "Portuguese", "Bengali", "Russian"
    ]

    var body: some View {
        if isSignedUp {
            MainTabView()
        } else {
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

                        Text("Create Account")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)

                        Group {
                            textField("First Name", text: $firstName)
                            textField("Second Name", text: $secondName)
                            textField("Email", text: $email, keyboardType: .emailAddress)
                            secureField("Password", text: $password)
                            datePicker("Date of Birth", date: $dateOfBirth)
                            textField("Phone Number", text: $phoneNumber, keyboardType: .phonePad)

                            VStack(alignment: .leading) {
                                Text("Preferred Language")
                                    .foregroundColor(.white)
                                    .font(.footnote)
                                Picker("Preferred Language", selection: $selectedLanguage) {
                                    ForEach(popularLanguages, id: \.self) { language in
                                        Text(language).tag(language)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(.white)
                            }
                        }

                        Button(action: {
                            signUp()
                        }) {
                            Text("Create Account")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)

                        if showConfirmation {
                            Text("🎉 Account created successfully!")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                .alert("Sign Up Error", isPresented: $showingErrorAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            }
        }
    }

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

    @ViewBuilder
    func datePicker(_ title: String, date: Binding<Date>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundColor(.white)
                .font(.footnote)

            DatePicker("", selection: date, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .foregroundColor(.white)
        }
    }

    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Sign up failed: \(error.localizedDescription)"
                showingErrorAlert = true
                print("🔥 Firebase Auth Error:", error)
                return
            }

            guard let uid = result?.user.uid else {
                errorMessage = "Failed to get user ID."
                showingErrorAlert = true
                return
            }

            let userData: [String: Any] = [
                "firstName": firstName,
                "secondName": secondName,
                "email": email,
                "dob": Timestamp(date: dateOfBirth),
                "phone": phoneNumber,
                "language": selectedLanguage
            ]

            Firestore.firestore().collection("users").document(uid).setData(userData) { err in
                if let err = err {
                    errorMessage = "Failed to save user data: \(err.localizedDescription)"
                    showingErrorAlert = true
                    print("🔥 Firestore Error:", err)
                } else {
                    showConfirmation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        isSignedUp = true
                    }
                }
            }
        }
    }
}

