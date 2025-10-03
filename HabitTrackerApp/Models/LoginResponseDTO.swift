//
//  LoginResponseDTO.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 02.10.25.
//

import Foundation

struct LoginResponseDTO: Codable {
    let error: Bool
    var reason: String?
    let token: String?
    let userId: UUID
    
}
