//
//  RulesView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import SwiftUI

struct RulesView: View {
    var viewModel = RulesViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            Text(viewModel.descriptionRules)
                .multilineTextAlignment(.leading)
                .padding(.all)
            
            RulesCaroselloView(title: "Località", rules: viewModel.getLocationsRules())
                .padding(.horizontal)
            
            RulesCaroselloView(title: "Eventi", rules: viewModel.getEventsRules())
                .padding(.horizontal)

            RulesCaroselloView(title: "Malus", rules: viewModel.getMalusRules())
                .padding(.horizontal)
            
        }
    }
}

#Preview {
    RulesView()
}
