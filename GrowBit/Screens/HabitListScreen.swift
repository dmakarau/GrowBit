//
//  ItemScreen.swift
//  GrowBit
//
//  Created by Denis Makarau on 14.10.25.
//

import SwiftUI
import GrowBitSharedDTO

struct HabitListScreen: View {
    @State private var  viewModel: HabitListViewModel
    @State private var showAddHabit = false
    
    init(viewModel: HabitListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List(1 ... 10, id: \.self) { index in
                Text("Habit \(index)")
            }
        }
        .navigationTitle("Some Category")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add Habit") {
                    showAddHabit = true
                }
            }
        }
        .sheet(isPresented: $showAddHabit) {
            Text("Add Habit Screen")
            // Add Habit Screen here
        }
    }
}

#Preview {
    let authService = AuthenticationService()
    let networkService = NetworkService(httpClient: HTTPClient(), authService: authService)
    let coordinator = AppCoordinator()
    let category = CategoryResponseDTO(id: UUID(), name: "Health", colorCode: "#FF5733")
    let viewModel = HabitListViewModel(networkService: networkService, coordinator: coordinator, category: category)
    NavigationStack {
        HabitListScreen(viewModel: viewModel)
    }
}
