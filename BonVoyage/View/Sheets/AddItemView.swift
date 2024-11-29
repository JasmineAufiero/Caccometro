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
    var rankingViewModel: RankingViewModel
    var rulesViewModel: RulesViewModel = RulesViewModel()
    
    var body: some View {
        Form {
            Section {
                Text("Concorrente").font(.title2).fontWeight(.semibold)
                Text("Scegli il concorrente a cui vuoi assegnare dei punti.").font(.headline).fontWeight(.regular)
                
                let items = rankingViewModel.mapcompetitorsToGenericItems(rankingViewModel.competitors)
                CarouselView(items: items)
            }
            
            Section {
                Text("Punteggio").font(.title2).fontWeight(.semibold)
                Text("Tap per assegnare un punteggio, long tap per leggere i dettagli del regolamento.").font(.headline).fontWeight(.regular)
                
                VStack {
                    Text("Punteggio Località").font(.headline).fontWeight(.semibold)
                    
                    let locationRules = rankingViewModel.mapRulesToGenericItems(rulesViewModel.getLocationsRules())
                    CarouselView(items: locationRules)
                    
                    Text("Punteggio Evento").font(.headline).fontWeight(.semibold)
                    let eventRules = rankingViewModel.mapRulesToGenericItems(rulesViewModel.getEventsRules())
                    CarouselView(items: eventRules)
                    
                    Text("Punteggio Malus").font(.headline).fontWeight(.semibold)
                    let malusRules = rankingViewModel.mapRulesToGenericItems(rulesViewModel.getMalusRules())
                    CarouselView(items: malusRules)
                }
            }
            
        }
        .navigationBarTitle("Aggiorna la classifica", displayMode: .inline)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button("Salva") {
                    //TODO: gestire il salvataggio dell'item e aggiornamento classifica
                    isShowingItemSheet.toggle()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading)
            {
                Button("Annulla") {
                    isShowingItemSheet.toggle()
                }
            }
        }
    }
}

//#Preview {
//    AddItemView()
//}
