import SwiftUI
import SwiftData

struct RegisterView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var user: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false

    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
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

            VStack(spacing: 24) {
                Spacer(minLength: 24)

                Image(systemName: "person.badge.plus")
                    .font(.system(size: 48, weight: .bold))
                    .frame(width: 86, height: 86)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                VStack(spacing: 14) {
                    TextGlassField(
                        title: "Nome",
                        text: $name,
                        isSecure: false
                    )

                    TextGlassField(
                        title: "Usuário",
                        text: $user,
                        isSecure: false
                    )

                    PasswordField(
                        title: "Senha",
                        text: $password,
                        isVisible: $isPasswordVisible
                    )

                    PasswordField(
                        title: "Confirmar senha",
                        text: $confirmPassword,
                        isVisible: $isConfirmPasswordVisible
                    )
                }
                .padding(.top, 8)

                Button {
                    register()
                } label: {
                    Text("Registrar")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glass)
                .controlSize(.large)
                .tint(.blue)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial, in: Capsule())
                .padding(.top, 24)

                Button {
                    dismiss()
                } label: {
                    Text("Já tenho conta")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(.top, 2)
                }

                Spacer()
            }
            .padding(.horizontal, 34)
            .padding(.top, 24)
        }
        .navigationTitle("Registrar")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Cadastro", isPresented: $showAlert) {
            Button("OK") {
                if alertMessage == "Conta criada com sucesso!" {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    private func register() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedUser = user.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty, !trimmedUser.isEmpty else {
            alertMessage = "Preencha nome e usuário."
            showAlert = true
            return
        }

        guard password.count >= 6 else {
            alertMessage = "A senha precisa ter no mínimo 6 caracteres."
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            alertMessage = "As senhas não conferem."
            showAlert = true
            return
        }

        let account = UserAccount(name: trimmedName, username: trimmedUser, password: password)

        modelContext.insert(account)

        do {
            try modelContext.save()
            alertMessage = "Conta criada com sucesso!"
            showAlert = true
        } catch {
            alertMessage = "Erro ao salvar: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        RegisterView()
    }
    .modelContainer(for: [UserAccount.self], inMemory: true)
}
