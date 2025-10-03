//
//  RegisterResponseDTO.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 29.09.25.
//

import Foundation

struct RegisterResponseDTO: Codable {
    let error: Bool
    var reason: String?
}
