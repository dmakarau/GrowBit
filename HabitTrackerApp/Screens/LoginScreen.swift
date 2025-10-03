//
//  LoginScreen.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 02.10.25.
//

import SwiftUI

struct LoginScreen: View {

    @Environment(HabitsViewModel.self) private var habitsViewModel
    @Environment(AppState.self) private var appState

    @State var username = ""
    @State var password = ""
    @State var serverErrorMessage: String? = nil
    @State var clientErrorMessage: String? = nil
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && password.count >= 6
    }
    
    private func login ()  async {
        do {
            let loginResponseDTO = try await habitsViewModel.login(username: username, password: password)
            if loginResponseDTO.error {
                clientErrorMessage = loginResponseDTO.reason ?? ""
            } else {
                // take the user to categories list screen
                appState.routes.append(.categoriesList)
            }
        } catch {
            serverErrorMessage = error.localizedDescription
        }
    }
    
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            SecureField("Password", text: $password)

            HStack {
                Button("Login") {
                    serverErrorMessage = ""
                    clientErrorMessage = ""
                    Task { await login() }
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
            }
            Text(serverErrorMessage ?? "")
            Text(clientErrorMessage ?? "")
        }
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
            .environment(HabitsViewModel())
            .environment(AppState())
    }
}
