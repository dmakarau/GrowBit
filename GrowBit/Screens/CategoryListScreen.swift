//
//  CategoryListScreen.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import SwiftUI
import GrowBitSharedDTO

struct CategoryListScreen: View {
    @State private var viewModel: CategoriesViewModel
    @State private var showAddCategory = false
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Categories...")
                
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                    Button("Retry") {
                    }
                    .padding()
                }
            } else {
                List {
                    ForEach(viewModel.categories) { category in
                        HStack {
                            Circle()
                                .fill(Color.fromHex(category.colorCode))
                                .frame(width: 25, height: 25)
                            Text(category.name)
                        }
                        .onTapGesture {
                            viewModel.navigateToHabitList(for: category)
                        }
                    }
                }
                .navigationTitle("Categories")
                .toolbar {
                    Button("Add") {
                        showAddCategory = true
                    }
                }
                .sheet(isPresented: $showAddCategory) {
                    NavigationStack {
                        AddCategoryScreen(viewModel: AddCategoryViewModel(networkService: viewModel.networkService)) { newCategory in
                            viewModel.addCategory(newCategory)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let mockService = MockNetworkService()
    let coordinator = AppCoordinator()
    let viewModel = CategoriesViewModel(networkService: mockService, coordinator: coordinator)
    NavigationStack {
        CategoryListScreen(viewModel: viewModel)
    }
}
