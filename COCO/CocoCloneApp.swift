import Foundation
import SwiftUI
import GoogleSignIn

@main
struct CocoCloneApp: App {
    @StateObject private var authManager = AuthenticationManager.shared
    
    init() {
        // Configure Google Sign In
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String else {
            fatalError("No client ID found in Info.plist")
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientId)
    }
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                AllNotesView()
            } else {
                LoginView()
            }
        }
    }
}
