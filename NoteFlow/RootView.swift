import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState // TODO: change the state the check all the time like a async fucntion
    var body: some View {
        switch appState.authState {
        case .unknown:
            ProgressView("Checking sign-in status...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
        case .signedIn:
            AllNotesView()
        case .signedOut:
            LoginView()
        }
    }
}
