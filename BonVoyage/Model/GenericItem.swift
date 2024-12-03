//
//  IdentifiableObject.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 28/11/24.
//

import Foundation

struct GenericItem: Identifiable, Hashable, Equatable {
    var id: UUID
    var name: String?
    var image: String?
    var isSelected: Bool?
    var pageWidth: CGFloat
    var pageHeight: CGFloat
    var pointsDescription: String?
    var description: String?
    var itemType: ItemType
}


enum ItemType {
    case rule
    case competitor
}


