//
//  Rule.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import Foundation

struct Rule: Equatable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String?
    var description: String?
    var image: String?
    var points: Int
    var ruleType: RuleType
    
    var ruleTypeDescription: String {
        switch ruleType {
        case .events:
            "Eventi"
        case .locations:
            "Località"
        case .malus:
            "Malus"
        }
    }
    
    var pointsDescription: String {
        if points > 0 {
           return "+" + String(points)
        }
        else {
            return String(points)
        }
    }
}

enum RuleType {
    case events
    case locations
    case malus
}


