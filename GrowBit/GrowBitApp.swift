//
//  GrowBitApp.swift
//  GrowBit
//
//  Created by Denis Makarau on 23.09.25.
//

import SwiftUI

@main
struct GrowBitApp: App {
    @State private var coordinator = AppCoordinator()

    let httpClient: HTTPClient
    let authService: AuthenticationServiceProtocol
    let networkService: NetworkServiceProtocol

    init() {
        self.authService = AuthenticationService()
        self.httpClient = HTTPClient(authService: authService)
        self.networkService = NetworkService(httpClient: httpClient, authService: authService)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.routes) {
                RegistrationScreen(
                    viewModel: RegistrationViewModel(
                        networkService: networkService,
                        coordinator: coordinator
                    )
                )
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginScreen(
                            viewModel: LoginViewModel(
                                networkService: networkService,
                                authService: authService,
                                coordinator: coordinator
                            )
                        )
                    case .register:
                        RegistrationScreen(
                            viewModel: RegistrationViewModel(
                                networkService: networkService,
                                coordinator: coordinator
                            )
                        )
                    case .categoriesList:
                        CategoryListScreen(
                            viewModel: CategoriesViewModel(
                                networkService: networkService,
                                coordinator: coordinator
                            
                            )
                        )
                    case .habitsList(let category):
                        Text("Habits for category: \(category)")
                    }
                }
            }
        }
    }
}
