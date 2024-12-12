//
//  PageControl.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 12/12/24.
//

import SwiftUI

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int?
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages) { index in
                Circle()
                    .fill(currentPage == index ? .yellow : .gray)
                    .frame(width: 8, height: 8)
                    .onTapGesture {
                        self.currentPage = index
                    }
            }
        }
    }
}

//#Preview {
//    PageControl()
//}
