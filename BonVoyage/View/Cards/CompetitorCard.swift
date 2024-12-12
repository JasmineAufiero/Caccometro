//
//  AddCompetitorsCard.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 15/10/24.
//

import SwiftUI

struct CompetitorCard: View {
    var image: String?
    var name: String?
    var ranking: Int?
    var points: Int?

    var body: some View {
                
        HStack {
            
            if let ranking = self.ranking {
                Text(String(ranking))
                    .foregroundStyle(.gray)
            }
            
            if let image = image, let name = name {
                Image(image)
                   .resizable()
                   .frame(width: 50, height: 50)
                   .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(name)
                    .font(.headline)
            }
            
            Spacer()
            
            if let points = self.points {
                Text(String(points) + " punti")
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    CompetitorCard(image: "character5", name: "Porco Magico", ranking: 1, points: 100)
}
