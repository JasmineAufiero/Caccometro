//
//  CarouselView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 28/11/24.
//

import SwiftUI

struct CarouselView: View {
    @State var scrollPosition: Int?
    private let pageWidth: CGFloat = 150
    private let pageHeight: CGFloat = 200
    @State var selectedCompetitor: Competitor?
    let competitors: [Competitor]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15, content: {
                ForEach(competitors.indices, id: \.self) {
                    index in
                    let competitor = competitors[index]
                    let isSelected = isCompetitorSelected(competitor: competitor)
                    
                    
                    VStack(spacing: 10, content: {
                        Image(competitor.image ?? "person.fill.questionmark").resizable().scaledToFit()
                        
                        Text(competitor.name ?? "").bold()
                        
                    }).padding()
                        .frame(width: isSelected ? pageWidth * 1.2 : pageWidth, height: isSelected ? pageHeight * 1.2 : pageHeight).background(RoundedRectangle(cornerRadius: 16).fill(isSelected ? Color.yellow : Color.yellow.opacity(0.5)))
                        .scaleEffect(index == scrollPosition ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: scrollPosition)
                        .onTapGesture {
                        selectedCompetitor = competitor
                        scrollPosition = index
                    }
                }
            })
        }.scrollIndicators(.hidden)
    } /// stabilisce se il competitor passato in input è stato selezionato
    
    func isCompetitorSelected(competitor: Competitor) -> Bool{ return competitor.id == selectedCompetitor?.id
    }
}


#Preview {
    CarouselView(competitors: [
        Competitor(id: UUID(), name: "Competitor 1", image: "character1"),
        Competitor(id: UUID(), name: "Competitor 2", image: "character2"),
        Competitor(id: UUID(), name: "Competitor 3", image: "character3")
    ])
}


