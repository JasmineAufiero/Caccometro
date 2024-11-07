//
//  Competitor.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import Foundation
import SwiftUICore

struct Competitor :Hashable, Equatable {
    var id: UUID = UUID()
    var name: String
    var points: Int?
    var itemsPerDay: Int? // numero di cacche al giorno
    var colors: Color?
    var image: String?
    var locations: [Location]?
}
