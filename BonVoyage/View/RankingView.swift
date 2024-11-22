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
            if tripViewModel.competitors.isEmpty {
                Text("Non c'è nessun competitor al momento")
            } else {
                List {
                    ForEach(tripViewModel.competitors, id: \.self) { competitor in
                        AddCompetitorsCard(image: competitor.image ?? "", name: competitor.name, ranking: tripViewModel.competitors.firstIndex(of: competitor) ?? 0, points: 101)
                    }
                    .onDelete(perform: removeCompetitor)
                }
            }
        }
        .navigationBarTitle("Classifica", displayMode: .inline)
        .toolbarTitleDisplayMode(.inline)
    }
    
    func removeCompetitor(at offsets: IndexSet) {
        for index in offsets {
            let competitor = tripViewModel.competitors[index]
            tripViewModel.removeCompetitor(competitor)
        }
    }
}


//#Preview {
//    RankingView()
//}
