//
//  RegistrationScreen.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 25.09.25.
//

import SwiftUI
import Observation

struct RegistrationScreen: View {
    
    @Environment(HabitsViewModel.self) private var habitsViewModel
    @Environment(AppState.self) private var appState
    @State var username = ""
    @State var password = ""
    @State var errorMessgeState: String? = nil
    
    var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && password.count >= 6
    }
    
    private func register ()  async {
        do {
            let registeredResponseDTO = try await habitsViewModel.register(username: username, password: password)
            if !registeredResponseDTO.error {
                // go to the Login screen
                appState.routes.append(.login)
            }
        } catch {
            errorMessgeState = error.localizedDescription
        }
    }
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            SecureField("Password", text: $password)

            HStack {
                Button("Register") {
                    Task { await register() }

                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
            }
            Text(errorMessgeState ?? "")
        }
        .navigationTitle("Registration")
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
            .environment(HabitsViewModel())
            .environment(AppState())
    }
}
