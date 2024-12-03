//
//  CarouselView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 28/11/24.
//

import SwiftUI

struct CarouselView: View {
    @State var scrollPosition: Int?
    @Binding var selectedItem: GenericItem?
    
    let items: [GenericItem]
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        let isSelected = isItemSelected(item: item)
                        
                        CarouselCardView(item: item, isSelected: isSelected)
                            .onTapGesture {
                                if selectedItem == item {
                                    selectedItem = nil
                                    scrollPosition = nil
                                } else {
                                    selectedItem = item
                                    scrollPosition = index
                                }
                            }
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.3) // Adjusts the opacity during transitions.
                                    .scaleEffect(phase.isIdentity ? 1 : 0.3) // Scales the Rectangle based on its scroll phase.
                                    .offset(x: phase.isIdentity ? 0 : 20, // Moves the Rectangle horizontally
                                            y: phase.isIdentity ? 0 : 20) // and vertically during transition.
                            }
                            .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.95, alignment: .center)
                    }
                }
                .scrollTargetLayout() // Marks the parent layout as a target for scroll behaviors, aiding alignment.
            }
            .scrollTargetBehavior(.viewAligned) // Aligns scrolled content based on the geometries of the views.
            .safeAreaPadding(.horizontal, 21) // Applies horizontal padding to respect the device's safe area.
        }
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
        
        switch item.itemType {
            case .rule:
                VStack(spacing: 10) {
                    Image(item.image ?? "person.fill.questionmark")
                        .resizable()
                        .scaledToFit()

                    Text(item.name ?? "").bold()
                    Text(item.pointsDescription ?? "") .bold()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(isSelected ? Color.yellow : Color.yellow.opacity(0.5)))
                
            default:
                VStack(spacing: 10) {
                    Image(item.image ?? "person.fill.questionmark")
                        .resizable()
                        .scaledToFit()

                    Text(item.name ?? "").bold()
                    Text(item.pointsDescription ?? "") .bold()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(isSelected ? Color.yellow : Color.yellow.opacity(0.5)))
        }
    }
}



//#Preview {
//    CarouselView(competitors: [
//        Competitor(id: UUID(), name: "Competitor 1", image: "character1"),
//        Competitor(id: UUID(), name: "Competitor 2", image: "character2"),
//        Competitor(id: UUID(), name: "Competitor 3", image: "character3")
//    ])
//}


