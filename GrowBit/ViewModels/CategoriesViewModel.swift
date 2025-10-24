//
//  CategoriesViewModel.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import GrowBitSharedDTO

@Observable
class CategoriesViewModel {
    
    let networkService: NetworkServiceProtocol
    var categories = [CategoryResponseDTO]()
    var errorMessage: String?
    var isLoading = false
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        Task { await populateCategories() }
    }
    
    func populateCategories() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }
        
//        try? await Task.sleep(nanoseconds: 3_000_000_000)

        do {
            self.categories = try await networkService.getCategories()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func addCategory(_ category: CategoryResponseDTO) {
        self.categories.append(category)
    }
    
    func deleteCategory(offset: IndexSet) async {
        for index in offset {
            let categoryId = categories[index].id
            do {
                _ = try await networkService.deleteCategory(categoryId: categoryId)
                categories.remove(at: index)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

