//
//  ItemViewModel.swift
//  GrowBit
//
//  Created by Denis Makarau on 14.10.25.
//

import Foundation
import GrowBitSharedDTO

@Observable
class HabitListViewModel {
    let networkService: NetworkServiceProtocol
    var items = [ItemResponseDTO]()
    let category: CategoryResponseDTO
    var errorMessage: String?
    var isLoading = false
    private let coordinator: AppCoordinatorProtocol
    
    init(networkService: NetworkServiceProtocol, coordinator: AppCoordinatorProtocol, category: CategoryResponseDTO) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.category = category
        Task { await populateItems() }
    }
    
    func populateItems() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }
        
//        try? await Task.sleep(nanoseconds: 3_000_000_000)

        do {
//            self.items = try await networkService.getItems()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    
}
    
