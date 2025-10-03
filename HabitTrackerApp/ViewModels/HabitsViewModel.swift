//
//  HabitsViewModel.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 29.09.25.
//

import Foundation

@Observable
class HabitsViewModel {
    
    let httpClient = HTTPClient()
    
    func register(username: String, password: String)  async throws  -> RegisterResponseDTO {
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
        
        if !loginResponseDTO.error && loginResponseDTO.token != nil {
            let defaults = UserDefaults.standard
            defaults.set(loginResponseDTO.token!, forKey: "authToken")
            defaults.set(loginResponseDTO.userId.uuidString, forKey: "userId")
            return loginResponseDTO
        } else {
            throw NetworkError.serverError("Unable to login. Check your username and password.")
        }
    }
}
