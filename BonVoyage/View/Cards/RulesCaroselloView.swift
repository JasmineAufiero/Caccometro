//
//  RulesCaroselloView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import SwiftUI

struct RulesCaroselloView: View {
    var title: String
    var rules: [Rule]
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
                .padding([.top, .trailing], 20.0)
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach (self.rules) { rule in
                    RuleCardView(rule: rule)
                        .background(Color.teal.cornerRadius(10))
                        
                }
            }
        }
    }
}

#Preview {
    RulesCaroselloView(title: "Malus", rules: [Rule(name: "Intasatore di Cesso", description: "La persona che intaserà il cesso riceverà un meno tre punti e tutta la nostra ira.", image: "toilet.fill", points: -3, ruleType: .malus), Rule(name: "Cacatore Seriale", description: "Per più di quattro cacche al giorno si verrà puniti con meno due punti.", image: "hourglass.and.lock", points: -2, ruleType: .malus)])
}
