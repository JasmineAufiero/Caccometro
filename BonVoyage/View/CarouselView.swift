//
//  CarouselView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 28/11/24.
//

import SwiftUI

struct CarouselView: View {
    @State var scrollPosition: Int?
    @State var selectedItem: GenericItem?

    private let pageWidth: CGFloat = 150
    private let pageHeight: CGFloat = 200
    let items: [GenericItem]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    let isSelected = isItemSelected(item: item)
                    
                    CarouselCardView(item: item, isSelected: isSelected)
                    .scaleEffect(index == scrollPosition ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: scrollPosition)
                    .onTapGesture {
                        if selectedItem == item {
                            selectedItem = nil
                            scrollPosition = nil
                        } else {
                            selectedItem = item
                            scrollPosition = index
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    func isItemSelected(item: GenericItem) -> Bool {
        return item.id == selectedItem?.id
    }
}



struct CarouselCardView: View {
    let item: GenericItem
    let isSelected: Bool
    @State private var showDetail = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image(item.image ?? "person.fill.questionmark")
                .resizable()
                .scaledToFit()

            Text(item.name ?? "").bold()
            Text(item.pointsDescription ?? "") .bold()
        }
        .padding()
        .frame(width: isSelected ? item.pageWidth*1.1 : item.pageWidth, height: isSelected ? item.pageHeight*1.1 : item.pageHeight)
        .background(RoundedRectangle(cornerRadius: 16).fill(isSelected ? Color.yellow : Color.yellow.opacity(0.5)))
    }
}



//#Preview {
//    CarouselView(competitors: [
//        Competitor(id: UUID(), name: "Competitor 1", image: "character1"),
//        Competitor(id: UUID(), name: "Competitor 2", image: "character2"),
//        Competitor(id: UUID(), name: "Competitor 3", image: "character3")
//    ])
//}


