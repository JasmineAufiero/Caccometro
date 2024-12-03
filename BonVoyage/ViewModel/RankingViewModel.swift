//
//  RankingViewModel.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 20/10/24.
//

import Foundation

class RankingViewModel: ObservableObject {
    @Published var competitors: [Competitor]
    
    init(competitors: [Competitor]) {
        self.competitors = competitors
    }
    
    /// ritorna i competitors ordinati per punti
    func getRanking() -> [Competitor] {
        return competitors.sorted { ($0.points ?? 0) > ($1.points ?? 0) }
    }
    
    /// funzione che effettua il mapping da Competitor a GenericItem per la costruzione del carosello per la selezione del competitor in AddItemView
    func mapCompetitorToGenericItem(_ competitor: Competitor, pageWidth: CGFloat?, pageHeight: CGFloat?) -> GenericItem {
        return GenericItem(
            id: competitor.id,
            name: competitor.name,
            image: competitor.image,
            pageWidth: pageWidth ?? 100,
            pageHeight: pageHeight ?? 100,
            itemType: .competitor
        )
    }

    func mapcompetitorsToGenericItems(_ competitors: [Competitor]) -> [GenericItem] {
        return competitors.map { competitor in mapCompetitorToGenericItem(competitor, pageWidth: 150, pageHeight: 200) }
    }
    
    /// funzione che effettua il mapping da Rule a GenericItem per la costruzione del carosello per la selezione dei punti in AddItemView
    func mapRuleToGenericItem(_ rule: Rule, pageWidth: CGFloat?, pageHeight: CGFloat?) -> GenericItem {
        return GenericItem(
            id: rule.id,
            name: rule.name,
            image: rule.image,
            pageWidth: pageWidth ?? 300,
            pageHeight: pageHeight ?? 500,
            pointsDescription: rule.pointsDescription,
            description: rule.description,
            itemType: .rule
        )
    }
    
    func mapRulesToGenericItems(_ rules: [Rule]) -> [GenericItem] {
        return rules.map { rule in mapRuleToGenericItem(rule, pageWidth: 300, pageHeight: 500) }
    }
    
    func setCompetitorPoints(items: [GenericItem]) -> Int {
        var points = 0
        for item in items {
            if let pointsDescription = item.pointsDescription, let itemPoints = Int(pointsDescription) {
                points += itemPoints
            }
        }
        return points
    }
    
    func updateCompetitors(_ newCompetitors: [Competitor]) {
        competitors = newCompetitors
    }
}

