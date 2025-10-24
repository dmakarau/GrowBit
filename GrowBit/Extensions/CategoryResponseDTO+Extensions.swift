//
//  CategoryResponseDTO+Extensions.swift
//  GrowBit
//
//  Created by Denis Makarau on 08.10.25.
//

import Foundation
import GrowBitSharedDTO

extension CategoryResponseDTO: @retroactive Identifiable {}
extension CategoryResponseDTO: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(colorCode)
    }
}

extension CategoryResponseDTO: @retroactive Equatable {
    public static func == (lhs: CategoryResponseDTO, rhs: CategoryResponseDTO) -> Bool {
        return lhs.id == rhs.id &&
                lhs.name == rhs.name &&
                lhs.colorCode == rhs.colorCode
        
    }
}


