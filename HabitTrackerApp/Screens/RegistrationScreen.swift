//
//  RegistrationScreen.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 25.09.25.
//

import SwiftUI
import Observation
import HabitTrackerAppSharedDTO

struct RegistrationScreen: View {

    @State private var viewModel: RegistrationViewModel

    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            TextField("Username", text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            SecureField("Password", text: $viewModel.password)

            HStack {
                Button("Register") {
                    Task {
                        await viewModel.register()
                    }
                }.buttonStyle(.borderless)
                    .disabled(!viewModel.isFormValid || viewModel.isLoading)

                if viewModel.isLoading {
                    ProgressView()
                }

                Spacer()
                Button("Login") {
                    viewModel.navigateToLogin()
                }.buttonStyle(.borderless)
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Registration")
    }
}

#Preview {
    let authService = AuthenticationService()
    let networkService = NetworkService(httpClient: HTTPClient(), authService: authService)
    let coordinator = AppCoordinator()
    let viewModel = RegistrationViewModel(networkService: networkService, coordinator: coordinator)

    return NavigationStack {
        RegistrationScreen(viewModel: viewModel)
    }
}
