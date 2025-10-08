//
//  HTTPClient.swift
//  GrowBit
//
//  Created by Denis Makarau on 29.09.25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest(String)
    case unauthorized(String)
    case serverError(String)
    case decodingError
    case invalidResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("The URL provided was invalid.", comment: "badRequestError")
        case .badRequest(let message):
            return NSLocalizedString("Bad request: \(message)", comment: "badRequest")
        case .unauthorized(let message):
            return NSLocalizedString("Unauthorized: \(message)", comment: "unauthorizedError")
        case .serverError(let message):
            return NSLocalizedString("Server error: \(message)", comment: "serverError")
        case .decodingError:
            return NSLocalizedString("Failed to decode the response.", comment: "decodingError")
        case .invalidResponse:
            return NSLocalizedString("Received an invalid response from the server.", comment: "invalidResponseError")
        }
    }
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name : String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .delete: return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var modelType: T.Type
    var requiresAuth: Bool = false

}

protocol HTTPClientProtocol {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T
}

struct HTTPClient: HTTPClientProtocol {
    private let session: URLSession
    private let authService: AuthenticationServiceProtocol?

    init(session: URLSession? = nil, authService: AuthenticationServiceProtocol? = nil) {
        if let session = session {
            self.session = session
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
            self.session = URLSession(configuration: configuration)
        }
        self.authService = authService
    }

    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var urlRequest = URLRequest(url: resource.url)

        // Add auth header if resource requires authentication
        if resource.requiresAuth, let token = authService?.getToken() {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badURL
            }

            urlRequest = URLRequest(url: url)

        case .post(let data):
            urlRequest.httpMethod = resource.method.name
            urlRequest.httpBody = data

        case .delete:
            urlRequest.httpMethod = resource.method.name
        }

        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch response.statusCode {
        case 200...299:
            break // Successful response, proceed to decode
        case 400:
            throw NetworkError.badRequest("Bad request")
        case 401:
            throw NetworkError.unauthorized("Unauthorized")
        case 409:
            throw NetworkError.serverError("Conflict")
        default:
            throw NetworkError.serverError("Server error with status code: \(response.statusCode)")
        }
        
        guard let result = try? JSONDecoder().decode(resource.modelType, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
