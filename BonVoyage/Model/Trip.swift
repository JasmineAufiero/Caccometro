//
//  Trip.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import Foundation

struct Trip: Identifiable {
    var id: UUID = UUID()
    var destination: String?
    var initialDate: String?
    var finalDate: String?
    var competitors: [Competitor]?
    
}
