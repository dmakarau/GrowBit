//
//  CategoryScreen.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import SwiftUI
import GrowBitSharedDTO

struct AddCategoryScreen: View {

    @State private var viewModel: AddCategoryViewModel
    var onAdd: (CategoryResponseDTO) -> Void

    @Environment(\.dismiss) private var dismiss

    init(viewModel: AddCategoryViewModel, onAdd: @escaping (CategoryResponseDTO) -> Void) {
        self.viewModel = viewModel
        self.onAdd = onAdd
    }

    var body: some View {
        Form {
            TextField("Category Name", text: $viewModel.categoryName)
            ColorSelector(colorCode: $viewModel.colorCode)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("New Category")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    Button("Save") {
                        Task {
                            let success = await viewModel.saveCategory()
                            if success {
                                onAdd(viewModel.createdCategory!)
                                dismiss()
                            }
                        }
                    }
                    .disabled(!viewModel.isFormValid || viewModel.isLoading)
                }
            }
        }
    }
}

#Preview {
    let authService = AuthenticationService()
    let networkService = NetworkService(httpClient: HTTPClient(), authService: authService)
    let viewModel = AddCategoryViewModel(networkService: networkService)

    NavigationStack {
        AddCategoryScreen(viewModel: viewModel) {
            print("Added category: \($0)")
        }
    }
}
