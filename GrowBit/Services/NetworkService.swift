//
//  NetworkService.swift
//  GrowBit
//
//  Created by Denis Makarau on 29.09.25.
//

import Foundation
import GrowBitSharedDTO

protocol NetworkServiceProtocol {
    func register(username: String, password: String) async throws -> RegisterResponseDTO
    func login(username: String, password: String) async throws -> LoginResponseDTO
    func saveCategory(_ categoryRequestDTO: CategoryRequestDTO) async throws -> CategoryResponseDTO
}

@Observable
class NetworkService: NetworkServiceProtocol {

    private let httpClient: HTTPClientProtocol
    private let authService: AuthenticationServiceProtocol

    init(httpClient: HTTPClientProtocol, authService: AuthenticationServiceProtocol) {
        self.httpClient = httpClient
        self.authService = authService
    }

    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        let registrationData = ["username": username, "password": password]
        let resource = try Resource(
            url: Constants.Urls.register,
            method: .post(JSONEncoder().encode(registrationData)),
            modelType: RegisterResponseDTO.self
        )

        let registerResponseDTO = try await httpClient.load(resource)
        return registerResponseDTO
    }

    func login(username: String, password: String) async throws -> LoginResponseDTO {
        let loginData = ["username": username, "password": password]

        let resource = try Resource(
            url: Constants.Urls.login,
            method: .post(JSONEncoder().encode(loginData)),
            modelType: LoginResponseDTO.self
        )
        let loginResponseDTO = try await httpClient.load(resource)

        if loginResponseDTO.error {
            throw NetworkError.serverError(loginResponseDTO.reason ?? "Unable to login. Check your username and password.")
        }

        return loginResponseDTO
    }

    func saveCategory(_ categoryRequestDTO: CategoryRequestDTO) async throws -> CategoryResponseDTO {
        guard let userId = authService.getUserId() else {
            throw NetworkError.unauthorized("User not authenticated")
        }

        var resource = try Resource(
            url: Constants.Urls.saveCategory(userId: userId),
            method: .post(JSONEncoder().encode(categoryRequestDTO)),
            modelType: CategoryResponseDTO.self
        )
        resource.requiresAuth = true

        let newCategory = try await httpClient.load(resource)
        return newCategory
    }
}
