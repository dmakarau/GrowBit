//
//  MockServices.swift
//  GrowBit
//
//  Created by Denis Makarau on 22.10.25.
//

import Foundation
import GrowBitSharedDTO

// MARK: - Mock Authentication Service
class MockAuthenticationService: AuthenticationServiceProtocol {
    private var token: String?
    private var userId: UUID?
    
    init(isAuthenticated: Bool = true) {
        if isAuthenticated {
            self.token = "mock_token_12345"
            self.userId = UUID()
        }
    }
    
    /// Convenience initializer for creating a mock service with specific credentials
    convenience init(token: String, userId: UUID) {
        self.init(isAuthenticated: false)
        self.token = token
        self.userId = userId
    }
    
    func saveToken(_ token: String) {
        self.token = token
    }
    
    func saveUserId(_ userId: UUID) {
        self.userId = userId
    }
    
    func getToken() -> String? {
        return token
    }
    
    func getUserId() -> UUID? {
        return userId
    }
    
    func clearAuthentication() {
        token = nil
        userId = nil
    }
    
    func isAuthenticated() -> Bool {
        return token != nil && userId != nil
    }
}

// MARK: - Mock HTTP Client
class MockHTTPClient: HTTPClientProtocol {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Return mock data based on the resource type
        if T.self == [CategoryResponseDTO].self {
            let mockCategories = [
                CategoryResponseDTO(
                    id: UUID(),
                    name: "Health & Fitness",
                    colorCode: "#FF6B6B"
                ),
                CategoryResponseDTO(
                    id: UUID(),
                    name: "Learning",
                    colorCode: "#4ECDC4"
                ),
                CategoryResponseDTO(
                    id: UUID(),
                    name: "Productivity",
                    colorCode: "#45B7D1",
                ),
                CategoryResponseDTO(
                    id: UUID(),
                    name: "Social",
                    colorCode: "#96CEB4"
                ),
                CategoryResponseDTO(
                    id: UUID(),
                    name: "Personal Development",
                    colorCode: "#FFEAA7"
                )
            ]
            return mockCategories as! T
        } else if T.self == CategoryResponseDTO.self {
            let mockCategory = CategoryResponseDTO(
                id: UUID(),
                name: "New Category",
                colorCode: "#FF6B6B"
            )
            return mockCategory as! T
        } else if T.self == LoginResponseDTO.self {
            let mockLoginResponse = LoginResponseDTO(
                error: false, reason: nil, token: "mock_token_12345",
                userId: UUID()
            )
            return mockLoginResponse as! T
        } else if T.self == RegisterResponseDTO.self {
            let mockRegisterResponse = RegisterResponseDTO(
                error: false,
                reason: nil
            )
            return mockRegisterResponse as! T
        }
        
        throw NetworkError.decodingError
    }
}

// MARK: - Mock Network Service
class MockNetworkService: NetworkServiceProtocol {
    private let httpClient: HTTPClientProtocol
    private let authService: AuthenticationServiceProtocol
    
    init() {
        self.authService = MockAuthenticationService(isAuthenticated: true)
        self.httpClient = MockHTTPClient()
    }
    
    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        let resource = Resource(
            url: URL(string: "https://mock.example.com/register")!,
            method: .post(nil),
            modelType: RegisterResponseDTO.self
        )
        return try await httpClient.load(resource)
    }
    
    func login(username: String, password: String) async throws -> LoginResponseDTO {
        let resource = Resource(
            url: URL(string: "https://mock.example.com/login")!,
            method: .post(nil),
            modelType: LoginResponseDTO.self
        )
        return try await httpClient.load(resource)
    }
    
    func saveCategory(_ categoryRequestDTO: CategoryRequestDTO) async throws -> CategoryResponseDTO {
        let resource = Resource(
            url: URL(string: "https://mock.example.com/categories")!,
            method: .post(nil),
            modelType: CategoryResponseDTO.self,
            requiresAuth: true
        )
        return try await httpClient.load(resource)
    }
    
    func getCategories() async throws -> [CategoryResponseDTO] {
        let resource = Resource(
            url: URL(string: "https://mock.example.com/categories")!,
            method: .get([]),
            modelType: [CategoryResponseDTO].self,
            requiresAuth: true
        )
        return try await httpClient.load(resource)
    }
}
