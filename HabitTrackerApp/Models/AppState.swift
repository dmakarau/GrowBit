//
//  AppState.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 02.10.25.
//

import Foundation
import Observation

enum Route: Hashable {
    case login
    case register
    case categoriesList
    
}

@Observable
class AppState {
    var routes: [Route] = []
}
