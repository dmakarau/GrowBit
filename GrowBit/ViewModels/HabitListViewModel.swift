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
    var errorMessage: String?
    var isLoading = false
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
    
