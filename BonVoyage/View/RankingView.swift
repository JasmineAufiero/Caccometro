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
    @State var isShowingItemSheet: Bool = false
    @StateObject var rankingViewModel: RankingViewModel
    
    init(tripViewModel: TripViewModel) {
        _rankingViewModel = StateObject(wrappedValue: RankingViewModel(competitors: tripViewModel.competitors))
    }

    var body: some View {
        Section {
            if (tripViewModel.trip?.competitors) != nil {
                List {
                    Section {
                        ForEach(rankingViewModel.getRanking(), id: \.self) { competitor in
                            let position = rankingViewModel.competitors.firstIndex(of: competitor) ?? 0

                            CompetitorCard(image: competitor.image ?? "", name: competitor.name, ranking: position+1 , points: 0)
                        }
                    }
                }
            } else {
                Text("Non c'è nessun competitor al momento")
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            NavigationStack {
                AddTripView(isShowingSheet: $isShowingSheet)
                    .environmentObject(tripViewModel)
            }
        }
        .sheet(isPresented: $isShowingItemSheet) {
            NavigationStack {
                AddItemView(isShowingItemSheet: $isShowingItemSheet, rankingViewModel: rankingViewModel)
                    .environmentObject(tripViewModel)
            }
        }
        .environmentObject(tripViewModel)
        .toolbar {
            ToolbarItem(id: "addCompetitor") {
                Button {
                    print("Aggiungi cacca")
                    isShowingItemSheet.toggle()
                } label: {
                    Label("Aggiungi", systemImage: "plus")
                }
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
                    Label("Aggiungi", systemImage: "ellipsis.circle.fill")
                }
            }
        }
    }
}



//#Preview {
//    RankingView()
//}
