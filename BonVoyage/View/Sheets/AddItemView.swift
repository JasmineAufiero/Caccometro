//
//  AddItemView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 28/11/24.
//

import SwiftUI

struct AddItemView: View {
    var rankingViewModel: RankingViewModel
    var competitor: Competitor
    var rulesViewModel: RulesViewModel = RulesViewModel()
    
    @State var selectedEventRule: GenericItem?
    @State var selectedLocationRule: GenericItem?
    @State var selectedMalusRule: GenericItem?
    @State private var selection = 0
    @EnvironmentObject var tripViewModel: TripViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Picker")) {
                Text("Evento").tag(0)
                Text("Località").tag(1)
                Text("Malus").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selection {
            case 0:
                CarouselView(selectedItem: $selectedEventRule, items: rankingViewModel.mapRulesToGenericItems(rulesViewModel.rulesForRuleType(ruleType: .events)))
            case 1:
                CarouselView(selectedItem: $selectedLocationRule, items: rankingViewModel.mapRulesToGenericItems(rulesViewModel.rulesForRuleType(ruleType: .locations)))
            case 2:
                CarouselView(selectedItem: $selectedMalusRule, items: rankingViewModel.mapRulesToGenericItems(rulesViewModel.rulesForRuleType(ruleType: .malus)))
            default:
                EmptyView()
            }
        }
        .navigationBarTitle("Punteggio", displayMode: .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Salva") {
                    //TODO: salvare punteggio per competitor
                    saveCompetitorPoints()
                    presentationMode.wrappedValue.dismiss() // Chiude la vista
                }
            }
        }
    }
    
    func setSelectedrules() -> [GenericItem] {
        var rules: [GenericItem] = []
        if let selectedEventRule {
            rules.append(selectedEventRule)
        }
        if let selectedLocationRule {
            rules.append(selectedLocationRule)
        }
        if let selectedMalusRule {
            rules.append(selectedMalusRule)
        }
        return rules
    }
    
    func saveCompetitorPoints() {
        let points = rankingViewModel.setCompetitorPoints(items: setSelectedrules())
        tripViewModel.updateCompetitorPoints(competitorId: competitor.id, newPoints: points)
    }
    
}

//#Preview {
//    AddItemView()
//}
