//
//  MapsView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import SwiftUI
import _MapKit_SwiftUI

struct MapsView: View {
    @State private var position = MapCameraPosition.automatic
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true

    var body: some View {
        // 3
        Map(position: $position, selection: $selectedLocation) {
            // 4
            ForEach(searchResults) { result in
                Marker(coordinate: result.location) {
                    Image(systemName: "mappin")
                }
                .tag(result)
            }
        }
        .onChange(of: selectedLocation) {
            isSheetPresented = selectedLocation == nil
        }
      
        .onChange(of: searchResults) {
            if let firstResult = searchResults.first, searchResults.count == 1 {
                selectedLocation = firstResult
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SearchMapView(searchResults: $searchResults)
        }
    }
}

#Preview {
    MapsView()
}
