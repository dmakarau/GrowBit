//
//  HabitTrackerAppApp.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 23.09.25.
//

import SwiftUI

@main
struct HabitTrackerAppApp: App {
    @State private var appState = AppState()
    @State private var habitsViewModel = HabitsViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                RegistrationScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            LoginScreen()
                        case .register:
                            RegistrationScreen()
                        case .categoriesList:
                            Text("Categories List") // CategoriesListScreen()
                        }
                    }
            }
            .environment(habitsViewModel)
            .environment(appState)
        }
    }
}
