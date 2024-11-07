//
//  AddCompetitorsCard.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 15/10/24.
//

import SwiftUI

struct AddCompetitorsCard: View {
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
                   .clipShape(Circle())
                   .overlay(Circle().stroke(Color.white, lineWidth: 4))
                   .padding(.all, 5.0)

                
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
    AddCompetitorsCard(image: "character5", name: "Porco Magico", ranking: 1, points: 100)
}
