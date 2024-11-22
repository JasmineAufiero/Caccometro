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
    var points: Int16?
    var itemsPerDay: Int16? // numero di cacche al giorno
//    var color: Color?
    var image: String?
//    var locations: [Location]?
}
