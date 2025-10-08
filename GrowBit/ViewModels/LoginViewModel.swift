//
//  LoginViewModel.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import HabitTrackerAppSharedDTO

@Observable
class LoginViewModel {

    private let networkService: NetworkServiceProtocol
    private let authService: AuthenticationServiceProtocol
    private let coordinator: AppCoordinatorProtocol

    var username = ""
    var password = ""
    var errorMessage: String? = nil
    var isLoading = false

    init(networkService: NetworkServiceProtocol, authService: AuthenticationServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.networkService = networkService
        self.authService = authService
        self.coordinator = coordinator
    }

    var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && password.count >= 6
    }

    func login() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            let loginResponseDTO = try await networkService.login(username: username, password: password)

            // Save authentication data in ViewModel
            if let token = loginResponseDTO.token {
                authService.saveToken(token)
                authService.saveUserId(loginResponseDTO.userId)
                coordinator.navigateToCategoriesList()
            } else {
                errorMessage = "Invalid response from server"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
