//
//  AddItemView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 28/11/24.
//

import SwiftUI

struct AddItemView: View {
//    @EnvironmentObject var tripViewModel: TripViewModel
    @Binding var isShowingItemSheet: Bool
    var rankingViewModel = RankingViewModel()
    
    var body: some View {
        Form {
            Section {
                Text("Concorrente").font(.title2).fontWeight(.semibold)
                Text("Scegli il concorrente a cui vuoi assegnare dei punti.").font(.headline).fontWeight(.regular)

                //TODO: sostituire con competitor presi da viewmodel
                let competitors = [
                    Competitor(id: UUID(), name: "Competitor 1", image: "character1"),
                    Competitor(id: UUID(), name: "Competitor 2", image: "character2"),
                    Competitor(id: UUID(), name: "Competitor 3", image: "character3")
                                       ]
                
                let items = rankingViewModel.mapcompetitorsToGenericItems(competitors)
                CarouselView(items: items)

            }
            
            Section {
                Text("Punteggio").font(.title2).fontWeight(.semibold)
                Text("Tap per assegnare un punteggio, long tap per leggere i dettagli del regolamento.").font(.headline).fontWeight(.regular)
                
                VStack {
                    Text("Punteggio Località").font(.headline).fontWeight(.semibold)
                    
                    let rules = [Rule(name: "Nome Regola" , description: "Descrizione molto lunga di una regola. che verrà ottenuto attraverso un bellissimo magico long press", image: "rule", points: 1, ruleType: .locations ), Rule(name: "Nome Regola2" , description: "Descrizione molto lunga di una regola. che verrà ottenuto attraverso un bellissimo magico long press", image: "rule", points: 1, ruleType: .locations )]
                    
                    let itemrules = rankingViewModel.mapRulesToGenericItems(rules)
                    CarouselView(items: itemrules)
                    
                    Text("Punteggio Evento").font(.headline).fontWeight(.semibold)
                    
                    Text("Punteggio Malus").font(.headline).fontWeight(.semibold)
                }
            }
            
        }
        .navigationBarTitle("Aggiorna la classifica", displayMode: .inline)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button("Salva") {
//                    isShowingItemSheet.toggle()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading)
            {
                Button("Annulla") {
//                    isShowingItemSheet.toggle()
                }
            }
        }
    }
}

//#Preview {
//    AddItemView()
//}
