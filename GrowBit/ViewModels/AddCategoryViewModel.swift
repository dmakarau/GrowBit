//
//  AddCategoryViewModel.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import GrowBitSharedDTO

@Observable
class AddCategoryViewModel {

    private let networkService: NetworkServiceProtocol

    var categoryName = ""
    var colorCode = ""
    var errorMessage: String?
    var isLoading = false

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    var isFormValid: Bool {
        !categoryName.isEmptyOrWhitespace && !colorCode.isEmpty
    }

    func saveCategory() async -> Bool {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        let request = CategoryRequestDTO(
            name: categoryName,
            colorCode: colorCode
        )

        do {
            let savedCategory = try await networkService.saveCategory(request)
            // Category saved successfully with ID: savedCategory.id
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
