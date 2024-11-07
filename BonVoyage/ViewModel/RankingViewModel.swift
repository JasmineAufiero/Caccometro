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

}
