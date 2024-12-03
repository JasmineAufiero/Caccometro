//
//  RankingView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 20/10/24.
//

import SwiftUI

struct RankingView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @State var isShowingSheet: Bool = false
    @StateObject var rankingViewModel: RankingViewModel
    
    init(tripViewModel: TripViewModel) {
        _rankingViewModel = StateObject(wrappedValue: RankingViewModel(competitors: tripViewModel.competitors))
    }

    var body: some View {
        Section {
            if !tripViewModel.competitors.isEmpty {
                List {
                    Section {
                        ForEach(rankingViewModel.getRanking(), id: \.self) { competitor in
                            let position = rankingViewModel.competitors.firstIndex(of: competitor) ?? 0
                            
                            NavigationLink(destination: AddItemView(rankingViewModel: rankingViewModel, competitor: competitor)
                                .environmentObject(tripViewModel))
                            {
                                CompetitorCard(image: competitor.image ?? "", name: competitor.name, ranking: position + 1, points: Int(competitor.points ?? 0))
                            }
                        }
                    }
                }
            } else {
                Text("Non c'è nessun competitor al momento")
            }
        }
        .onReceive(tripViewModel.$competitors) { newCompetitors in
            rankingViewModel.updateCompetitors(newCompetitors)
        }
        .sheet(isPresented: $isShowingSheet) {
            NavigationStack {
                AddTripView(isShowingSheet: $isShowingSheet)
                    .environmentObject(tripViewModel)
            }
        }
        .environmentObject(tripViewModel)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Section {
                        Button {
                            tripViewModel.removeTrip()
                        } label: {
                            Text("Elimina Viaggio")
                        }
                        
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            Text("Modifica Viaggio")
                        }
                    }
                } label: {
                    // TODO: Cambiare
                    Label("Aggiungi", systemImage: "ellipsis.circle.fill")
                }
            }
        }
    }
}




//#Preview {
//    RankingView()
//}
