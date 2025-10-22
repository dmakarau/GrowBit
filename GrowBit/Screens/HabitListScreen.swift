//
//  ItemScreen.swift
//  GrowBit
//
//  Created by Denis Makarau on 14.10.25.
//

import SwiftUI

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
    let viewModel = HabitListViewModel(networkService: networkService)
    NavigationStack {
        HabitListScreen(viewModel: viewModel)
    }
}
