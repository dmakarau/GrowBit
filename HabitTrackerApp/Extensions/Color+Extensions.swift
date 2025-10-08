//
//  Color+Extensions.swift
//  HabitTrackerApp
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import SwiftUI

extension Color {
    static func fromHex(_ hexCode: String) -> Color {
        let scanner = Scanner(string: hexCode.replacingOccurrences(of: "#", with: ""))
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)
        
        let red = Double((hexNumber & 0xff0000) >> 16) / 255.0
        let green = Double((hexNumber & 0x00ff00) >> 8) / 255.0
        let blue = Double(hexNumber & 0x0000ff) / 255.0
    
        return Color(red: red, green: green, blue: blue)
    }
}
