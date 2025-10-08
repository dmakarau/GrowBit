//
//  AuthenticationService.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func saveToken(_ token: String)
    func saveUserId(_ userId: UUID)
    func getToken() -> String?
    func getUserId() -> UUID?
    func clearAuthentication()
    func isAuthenticated() -> Bool
}

class AuthenticationService: AuthenticationServiceProtocol {
    private enum Keys {
        static let authToken = "authToken"
        static let userId = "userId"
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveToken(_ token: String) {
        userDefaults.set(token, forKey: Keys.authToken)
    }

    func saveUserId(_ userId: UUID) {
        userDefaults.set(userId.uuidString, forKey: Keys.userId)
    }

    func getToken() -> String? {
        return userDefaults.string(forKey: Keys.authToken)
    }

    func getUserId() -> UUID? {
        guard let userIdString = userDefaults.string(forKey: Keys.userId) else {
            return nil
        }
        return UUID(uuidString: userIdString)
    }

    func clearAuthentication() {
        userDefaults.removeObject(forKey: Keys.authToken)
        userDefaults.removeObject(forKey: Keys.userId)
    }

    func isAuthenticated() -> Bool {
        return getToken() != nil && getUserId() != nil
    }
}
