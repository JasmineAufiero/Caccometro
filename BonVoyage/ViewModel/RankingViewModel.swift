//
//  RankingViewModel.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 20/10/24.
//

import Foundation

class RankingViewModel {
    var competitors: [Competitor] = [] // capire come prender i competitors
    
    // ritorna i competitors ordinati per punti
    func getRanking() -> [Competitor] {
        return competitors
    }
    
    /// funzione che effettua il mapping da Competitor a GenericItem per la costruzione del carosello per la selezione del competitor in AddItemView
    func mapCompetitorToGenericItem(_ competitor: Competitor, pageWidth: CGFloat?, pageHeight: CGFloat?) -> GenericItem {
        return GenericItem(
            id: competitor.id,
            name: competitor.name,
            image: competitor.image,
            pageWidth: pageWidth ?? 100,
            pageHeight: pageHeight ?? 100
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
            pageWidth: pageWidth ?? 100,
            pageHeight: pageHeight ?? 100,
            pointsDescription: rule.pointsDescription,
            description: rule.description
        )
    }
    
    func mapRulesToGenericItems(_ rules: [Rule]) -> [GenericItem] {
        return rules.map { rule in mapRuleToGenericItem(rule, pageWidth: 150, pageHeight: 200) }

    }
    

}
