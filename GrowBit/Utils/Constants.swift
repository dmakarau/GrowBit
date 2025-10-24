//
//  Constants.swift
//  GrowBit
//
//  Created by Denis Makarau on 29.09.25.
//

import Foundation

enum URLError: Error {
    case invalidURL
}

struct Constants {
    private static let baseURL = "http://127.0.0.1:8080/api"

    struct Urls {
        static var register: URL {
            get throws {
                guard let url = URL(string: "\(baseURL)/register") else {
                    throw URLError.invalidURL
                }
                return url
            }
        }

        static var login: URL {
            get throws {
                guard let url = URL(string: "\(baseURL)/login") else {
                    throw URLError.invalidURL
                }
                return url
            }
        }

        static func saveCategory(userId: UUID) throws -> URL {
            guard let url = URL(string: "\(baseURL)/\(userId)/categories") else {
                throw URLError.invalidURL
            }
            return url
        }
        
        static func getCategoriesForUser(userId: UUID) throws -> URL {
            try saveCategory(userId: userId)
        }
        
        static func deleteCategory(userId: UUID, categoryId: UUID) throws -> URL {
            guard let url = URL(string: "\(baseURL)/\(userId)/categories/\(categoryId)") else {
                throw URLError.invalidURL
            }
            return url
        }
    }
}
