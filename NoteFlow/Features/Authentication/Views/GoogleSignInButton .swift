import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Foundation
import SwiftData


@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}



struct GoogleSignInButton: View {
    @ObservedObject var authManager: AuthenticationManager
    
    var body: some View {
        Button(action: authManager.signIn) {
            HStack(spacing: 12) {
                Image("google") // Make sure to add google.png to assets
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text("Continue with Google")
                    .font(.system(.body, weight: .medium))
            }

            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundStyle(.tertiary)
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
            }
        }
        .buttonStyle(.plain)
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

// Helper type for error alerts
struct SignInError: Identifiable {
    let id = UUID()
    let error: Error
}

#Preview {
    LoginView()
}
