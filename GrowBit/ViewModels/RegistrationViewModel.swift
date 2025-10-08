//
//  RegistrationViewModel.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import HabitTrackerAppSharedDTO

@Observable
class RegistrationViewModel {

    private let networkService: NetworkServiceProtocol
    private let coordinator: AppCoordinatorProtocol

    var username = ""
    var password = ""
    var errorMessage: String? = nil
    var isLoading = false

    init(networkService: NetworkServiceProtocol, coordinator: AppCoordinatorProtocol) {
        self.networkService = networkService
        self.coordinator = coordinator
    }

    var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && password.count >= 6
    }

    func register() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            let registeredResponseDTO = try await networkService.register(username: username, password: password)
            if !registeredResponseDTO.error {
                coordinator.navigateToLogin()
            } else {
                errorMessage = registeredResponseDTO.reason ?? "Registration failed"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func navigateToLogin() {
        coordinator.navigateToLogin()
    }
}
