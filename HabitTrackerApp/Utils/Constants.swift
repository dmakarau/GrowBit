//
//  Constants.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 29.09.25.
//

import Foundation

struct Constants {
    private static let baseURL = "http://127.0.0.1:8080/api"
    
    struct Urls {
        static let register = URL(string: "\(baseURL)/register")!
        static let login = URL(string: "\(baseURL)/login")!
    }
}
