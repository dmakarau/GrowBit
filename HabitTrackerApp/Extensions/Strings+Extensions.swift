//
//  Strings+Extensions.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 25.09.25.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
