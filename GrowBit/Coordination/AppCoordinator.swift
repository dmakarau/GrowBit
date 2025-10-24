//
//  AppCoordinator.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import SwiftUI
import GrowBitSharedDTO

enum Route: Hashable, Equatable {
    case login
    case register
    case categoriesList
    case habitsList(categoryDTO: CategoryResponseDTO)
}

protocol AppCoordinatorProtocol {
    var routes: [Route] { get set }
    func navigateToLogin()
    func navigateToRegister()
    func navigateToCategoriesList()
    func navigateToHabitsList(for category: CategoryResponseDTO)
    func pop()
    func popToRoot()
}

@Observable
class AppCoordinator: AppCoordinatorProtocol {
    var routes: [Route] = []

    func navigateToLogin() {
        routes.append(.login)
    }

    func navigateToRegister() {
        routes.append(.register)
    }

    func navigateToCategoriesList() {
        routes.append(.categoriesList)
    }
    
    func navigateToHabitsList(for category: CategoryResponseDTO) {
        routes.append(.habitsList(categoryDTO: category))
    }

    func pop() {
        guard !routes.isEmpty else { return }
        routes.removeLast()
    }

    func popToRoot() {
        routes.removeAll()
    }
}
