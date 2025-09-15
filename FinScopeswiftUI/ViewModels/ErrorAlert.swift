//
//  ErrorAlert.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 30/06/2025.
//

import SwiftUI

extension View {
    func errorAlert(isPresented: Binding<Bool>, message: String?) -> some View {
        alert("Error", isPresented: isPresented) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(message ?? "An unknown error occurred.")
        }
    }
}

