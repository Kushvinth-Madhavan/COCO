import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInButton: View {
    @ObservedObject var authManager: AuthenticationManager
    
    var body: some View {
        GoogleSignInButtonRepresentable(action: authManager.signIn)
            .frame(height: 50)
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
        
            // MARK: Please remove me below - By Kabin Eshwar RR
            .padding(-3)
            .padding(.horizontal, -1)
            .padding(.bottom, -2)
            .padding(.vertical, -1)
            .mask {
                RoundedRectangle(cornerRadius: 12)  // Remove me later
            }
    }
}

struct GoogleSignInButtonRepresentable: UIViewRepresentable {
    let action: () -> Void
    
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.style = .wide
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator: NSObject {
        let action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func buttonTapped() {
            action()
        }
    }
}

#Preview {
    LoginView()
}
