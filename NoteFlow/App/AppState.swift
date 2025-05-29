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
    
    // Thanks to SOF, this will redirect the user to the AllNotesView from the auth

    init() {
        setupNotifications()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(handleUserSignedIn),
                                             name: NSNotification.Name("UserSignedIn"),
                                             object: nil)
    }
    
    @objc private func handleUserSignedIn() {
        DispatchQueue.main.async { [weak self] in
            self?.authState = .signedIn
        }
    }
    // Thanks to SOF, till here
    
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
