//
//  LoginViewModel.swift
//  AppMusica
//
//  Created by Rafael Almeida on 21/03/26.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var user: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false

    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var accounts: [UserAccount] = []
    
    func login() -> Bool {
        let trimmedUser = user.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedUser.isEmpty, !trimmedPassword.isEmpty else {
            alertMessage = "Preencha usuário e senha."
            showAlert = true
            return false
        }

        guard let found = accounts.first(where: { $0.username.lowercased() == trimmedUser.lowercased() }) else {
            alertMessage = "Usuário ou senha inválidos."
            showAlert = true
            return false
        }

        guard found.password == trimmedPassword else {
            alertMessage = "Usuário ou senha inválidos."
            showAlert = true
            return false
        }
        
        return true

    }
}
