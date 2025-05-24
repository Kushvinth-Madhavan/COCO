import SwiftUI
import GoogleSignIn

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var error: Error?
    
    // Store user info
    @AppStorage("userId") private var userId: String = ""
    @AppStorage("email") private var userEmail: String = ""
    @AppStorage("displayName") private var displayName: String = ""
    @AppStorage("profilePictureUrl") private var profilePictureUrl: String = ""
    
    static let shared = AuthenticationManager()
    
    private init() {} // Make init private since we're using shared instance
    
    func signIn() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                self?.error = error
                return
            }
            
            guard let user = result?.user else {
                self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data not found"])
                return
            }
            
            self?.updateUserData(user: user)
        }
    }
    
    func updateUserData(user: GIDGoogleUser) {
        userId = user.userID ?? ""
        userEmail = user.profile?.email ?? ""
        displayName = user.profile?.name ?? ""
        profilePictureUrl = user.profile?.imageURL(withDimension: 100)?.absoluteString ?? ""
        
        DispatchQueue.main.async { [weak self] in
            self?.isAuthenticated = true
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        userId = ""
        userEmail = ""
        displayName = ""
        profilePictureUrl = ""
        isAuthenticated = false
    }
}
