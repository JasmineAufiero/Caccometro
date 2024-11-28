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

    var body: some View {
        Section {
            if (tripViewModel.trip?.competitors) != nil {
                List {
                    Section {
                        ForEach(tripViewModel.competitors, id: \.self) { competitor in
                            CompetitorCard(image: competitor.image ?? "", name: competitor.name, ranking: tripViewModel.competitors.firstIndex(of: competitor) ?? 0, points: 0)
                        }
//                        .onDelete(perform: removeCompetitor)
                    }
                }
                //TODO: aggiungere immagine
            } else {
                Text("Non c'è nessun competitor al momento")
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            NavigationStack {
                AddTripView(isShowingSheet: $isShowingSheet)
                    .environmentObject(tripViewModel)
            }
        }.environmentObject(tripViewModel)
        .navigationBarTitle("Classifica", displayMode: .inline)
        .toolbar {
            // aggiungi cacca
            ToolbarItem(id: "addCompetitor") {
                // TODO: aggiungere cacca
                Button {
                    print("Aggiungi cacca")
                } label: {
                    Label("Aggiungi", systemImage: "plus")
                }
            }
            
            // modifica viaggio
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Section {
                        Button {
                            tripViewModel.removeTrip()
                        } label: {
                            Text("Elimina Viaggio")
                        }
                        
                        //TODO: aggiungere action modifica viaggio
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            Text("Modifica Viaggio")
                        }

                    }
                }
                label: {
                    Label("Aggiungi", systemImage: "ellipsis.circle.fill")
                }
            }
        }
    }
    
    /// rimuove un competitor dalla lista tramite swift left
//    func removeCompetitor(at offsets: IndexSet) {
//        for index in offsets {
//            let competitor = tripViewModel.competitors[index]
//            tripViewModel.removeCompetitor(competitor)
//        }
//    }
}


//#Preview {
//    RankingView()
//}
