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
        ZStack {
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
            } else if viewModel.categories.isEmpty {
                HStack {
                    Text("No categories available. Please add a new category.")
                }                .padding()
            }
            else {
                List {
                    ForEach(viewModel.categories) { category in
                        HStack {
                            Circle()
                                .fill(Color.fromHex(category.colorCode))
                                .frame(width: 25, height: 25)
                            Text(category.name)
                        }
                    }.onDelete { indexSet in
                        Task {await viewModel.deleteCategory(offset: indexSet) }
                    }
                }
            }
        }
        .navigationTitle("Categories")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Logout") {
                    
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddCategory = true
                } label: {
                    Image(systemName: "plus")
                }
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

#Preview {
    let authService = AuthenticationService()
    let networkService = NetworkService(httpClient: HTTPClient(), authService: authService)
    let viewModel = CategoriesViewModel(networkService: networkService)
    CategoryListScreen(viewModel: viewModel)
}
