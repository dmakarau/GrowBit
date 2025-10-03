//
//  HTTPClient.swift
//  HabitTrackerApp
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
    
}

struct HTTPClient {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var urlRequest = URLRequest(url: resource.url)
        
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
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch response.statusCode {
        case 200...299:
            break // Successful response, proceed to decode
        case 409:
            throw NetworkError.serverError("User is already taken")
        case 400:
            throw NetworkError.badRequest("User is not found")
        case 401:
            throw NetworkError.unauthorized("Invalid credentials")
        default:
            throw NetworkError.serverError("Server error with status code: \(response.statusCode)")
        }
        
        guard let result = try? JSONDecoder().decode(resource.modelType, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
