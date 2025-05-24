import SwiftUI
import GoogleSignIn

enum AuthState {
    case unknown
    case signedIn
    case signedOut
}

class AppState: ObservableObject {
    @Published var authState: AuthState = .unknown
    private let authManager = AuthenticationManager.shared
    
    func checkSignInStatus() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            DispatchQueue.main.async {
                if let user = user {
                    self?.authManager.updateUserData(user: user)
                    self?.authState = .signedIn
                } else {
                    self?.authState = .signedOut
                }
            }
        }
    }
}
