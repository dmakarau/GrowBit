//
//  LoginScreen.swift
//  GrowBit
//
//  Created by Denis Makarau on 02.10.25.
//

import SwiftUI
import GrowBitSharedDTO

struct LoginScreen: View {

    @State private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            TextField("Username", text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            SecureField("Password", text: $viewModel.password)

            HStack {
                Button("Login") {
                    Task {
                        await viewModel.login()
                    }
                }.buttonStyle(.borderless)
                    .disabled(!viewModel.isFormValid || viewModel.isLoading)

                if viewModel.isLoading {
                    ProgressView()
                }
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Login")
    }
}

#Preview {
    let mockAuthService = MockAuthenticationService(isAuthenticated: false)
    let mockNetworkService = MockNetworkService()
    let coordinator = AppCoordinator()
    let viewModel = LoginViewModel(networkService: mockNetworkService, authService: mockAuthService, coordinator: coordinator)

    return NavigationStack {
        LoginScreen(viewModel: viewModel)
    }
}
