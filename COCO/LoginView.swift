import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @StateObject private var authManager = AuthenticationManager.shared
    @State private var showingEmailSignup = false
    
    var body: some View {
        VStack {
            VStack {
                RoundedRectangle(cornerRadius: 17, style: .continuous)
                    .fill(.yellow)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .aspectRatio(1/1, contentMode: .fit)
                    .clipped()
                    .frame(width: 80)
                    .clipped()
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                    .overlay {
                        Image(systemName: "note.text")
                            .imageScale(.large)
                            .symbolRenderingMode(.monochrome)
                            .font(.system(size: 31, weight: .regular, design: .default))
                            .foregroundStyle(.black)
                    }
                Text("CocoClone")
                    .font(.system(.largeTitle, weight: .medium))
                Text("Smart Notes, Effortless Learning")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .padding()
            .frame(maxWidth: .infinity)
            .clipped()
            .background {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color(.quaternarySystemFill))
            }
            .padding()
            
            Text("Create an account to make and save your notes to share with friends")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
                .padding()
                .frame(maxWidth: .infinity)
                .clipped()
                .background {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color(.quaternarySystemFill))
                }
                .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 12) {
                GoogleSignInButton(authManager: authManager)
                    .frame(height: 50)
                
                Button(action: { showingEmailSignup.toggle() }) {
                    Text("Sign up with Email")
                        .padding(4)
                        .frame(maxWidth: .infinity)
                        .clipped()
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .foregroundStyle(.gray)
            }
            .font(.system(.title3, weight: .medium))
            .frame(width: 290)
            .clipped()
            
            Spacer()
            
            Button(action: { showingEmailSignup.toggle() }) {
                Text("Already signed up? Log in")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            
            Spacer()
                .frame(height: 48)
                .clipped()
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .padding(.top, 96)
    }
}
