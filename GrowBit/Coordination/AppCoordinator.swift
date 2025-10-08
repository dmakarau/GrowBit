//
//  AppCoordinator.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case login
    case register
    case categoriesList
}

protocol AppCoordinatorProtocol {
    var routes: [Route] { get set }
    func navigateToLogin()
    func navigateToRegister()
    func navigateToCategoriesList()
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

    func pop() {
        guard !routes.isEmpty else { return }
        routes.removeLast()
    }

    func popToRoot() {
        routes.removeAll()
    }
}
