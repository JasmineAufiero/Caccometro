//
//  RuleCardView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import SwiftUI

struct RuleCardView: View {
    var rule: Rule
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.clear)
            .overlay(
                RuleCardInside(rule: rule)
            )
            .padding(.all, 20.0)
            .frame(width: 300, height: 400)
    }
}


struct RuleCardInside: View {
    var rule: Rule
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            HStack {
                Text(rule.name ?? "" + "(" + rule.pointsDescription + ")")
                    .lineLimit(4)
            }
            .font(.title)
            .fontWeight(.heavy)
            .lineLimit(0)
            .padding(.all, 5.0)
            
            if let image = rule.image {
                Image(systemName: image)
                    .resizable()
                    .padding(.all, 5.0)
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            
            if let description = rule.description  {
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(10)
                    .padding(.all, 10.0)
            }
        }
    }
}

#Preview {
    RuleCardView(rule: Rule(name: "Nottambulo", description: "Ciascuna cacca notturna (ovvero rilasciata dalle 2 alle 6 di mattina) verrà premiata con un punto aggiuntivo", image: "moon.stars.fill", points: 1, ruleType: .events))
}

