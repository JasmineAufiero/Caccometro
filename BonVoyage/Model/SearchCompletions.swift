//
//  SearchCompletions.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 13/10/24.
//

import Foundation

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    var url: URL?
}
