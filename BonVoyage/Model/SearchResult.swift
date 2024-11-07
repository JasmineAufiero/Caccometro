//
//  SearchResult.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 13/10/24.
//

import Foundation
import CoreLocation

struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let location: CLLocationCoordinate2D

    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
