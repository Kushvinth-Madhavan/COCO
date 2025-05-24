//
//  SignInWithAppleButton.swift
//  NoteFlow
//
//  Created by Kushvinth Madhavan on 22/05/25.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    @ObservedObject var authManager: AuthenticationManager
    
    var body: some View {
        Button(action: {
            authManager.signIn()
        }) {
            HStack {
                Image(systemName: "apple.logo")
                Text("Sign in with Apple")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 1)
            )
        }
        .alert(item: Binding(
            get: { authManager.error.map { SignInError(error: $0) } },
            set: { _ in authManager.error = nil }
        )) { signInError in
            Alert(
                title: Text("Sign In Error"),
                message: Text(signInError.error.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct SignInError: Identifiable {
    let id = UUID()
    let error: Error
}
