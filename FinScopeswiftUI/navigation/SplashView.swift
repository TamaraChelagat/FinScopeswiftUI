//
//  SplashView.swift
//  FinScopeswiftUI
//
//  Created by Student1 on 17/06/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image("FinscopeLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)

                Text("Welcome to FinScope")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Master Your Money, Own Your Future.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                NavigationLink(destination: LoginView()) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                NavigationLink(destination: SignUpView()) {
                    Text("Get Started")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .background(Color.purple.edgesIgnoringSafeArea(.all))
    }
}
#Preview {
    SplashView()
}   
