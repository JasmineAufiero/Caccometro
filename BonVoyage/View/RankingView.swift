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
                            .padding()
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .leading) {
                                deleteOnePointAction(competitor: competitor)
                            }
                            .swipeActions(edge: .trailing) {
                                addOnePointAction(competitor: competitor)
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
            ToolbarItem(placement: .principal) {
                Text(tripViewModel.getDestination().capitalizedSentence)
                    .customFont()
            }
            
            
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
    
    /// gestisce lo swipe right: aggiunge un punto al competitor
    func addOnePointAction(competitor: Competitor) -> some View {
        Button {
            let points = rankingViewModel.setOnePointToCompetitor(competitor: competitor, isPositiveOne: true)
            tripViewModel.updateCompetitorPoints(competitorId: competitor.id, newPoints: points)
        } label: {
            VStack {
                Text("+1")
                    .bold()
            }
        }
        .tint(Color.green)
    }
    
    
    /// gestisce lo swipe left: toglie un punto al competitor, se non è già a 0
    func deleteOnePointAction(competitor: Competitor) -> some View {
        Button {
            let points = rankingViewModel.setOnePointToCompetitor(competitor: competitor, isPositiveOne: false)
            if points > 0 {
                tripViewModel.updateCompetitorPoints(competitorId: competitor.id, newPoints: points)
            }
        }
        label: {
            VStack {
                Text("-1")
                    .bold()
            }
        }
        .tint(Color.red)
    }
}




//#Preview {
//    RankingView()
//}
