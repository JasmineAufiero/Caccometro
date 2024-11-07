//
//  RankingView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 20/10/24.
//

import SwiftUI

struct RankingView: View {
    @EnvironmentObject var tripViewModel: TripViewModel

    var body: some View {
        
        Section {
            if let competitors = tripViewModel.getCompetitors() {
                
                List {
                    ForEach(competitors, id: \.self) { competitor in
                        AddCompetitorsCard(image: competitor.image, name: competitor.name, ranking: competitors.firstIndex(of: competitor), points: 101)
                    }
                }
            }
        }
        .navigationBarTitle("Classifica", displayMode: .inline)
            .toolbarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    RankingView()
//}
