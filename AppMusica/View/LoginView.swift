import Combine
import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState
    @Query var accounts: [UserAccount]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.25, blue: 0.35),
                        Color(red: 0.10, green: 0.65, blue: 0.95),
                        Color(red: 0.10, green: 0.75, blue: 0.35)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 18) {
                    Spacer(minLength: 24)

                    Image(systemName: "music.note")
                        .font(.system(size: 56, weight: .bold))
                        .frame(width: 86, height: 86)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                    VStack(spacing: 14) {
                        TextGlassField(
                            title: "Usuário",
                            text: $viewModel.user,
                            isSecure: false
                        )

                        PasswordField(
                            title: "Senha",
                            text: $viewModel.password,
                            isVisible: $viewModel.isPasswordVisible
                        )
                    }
                    .padding(.top, 8)

                    Button {
                        login()
                    } label: {
                        Text("Entrar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)
                    .tint(.blue)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial, in: Capsule())
                    .padding(.top, 24)

                    HStack(spacing: 12) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.white.opacity(0.35))
                        Text("ou")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.7))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.white.opacity(0.35))
                    }
                    .padding(.vertical, 8)

                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Registrar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)
                    .tint(.blue)
                    .background(.ultraThinMaterial, in: Capsule())
                    .padding(.top, 4)

                    Spacer()
                }
                .padding(.horizontal, 34)
                .padding(.top, 24)
            }
            .alert("Login", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.alertMessage)
            }
        }
        .onChange(of: accounts) { _, _ in
            viewModel.accounts = accounts
        }
    }

    private func login() {
        if viewModel.login() {
            withAnimation(.snappy) {
                appState.route = .home
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LoginView()
    }
    .modelContainer(for: [UserAccount.self], inMemory: true)
}
