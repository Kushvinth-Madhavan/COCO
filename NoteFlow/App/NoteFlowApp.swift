import Foundation
import SwiftUI
import GoogleSignIn

@main
struct NoteFlow: App {
    @StateObject private var appState = AppState()
    
    init() {
        // Configure Google Sign In
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String else {
            fatalError("No client ID found in Info.plist")
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientId)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .onAppear {
                    appState.checkSignInStatus()
                }
        }
    }
}
