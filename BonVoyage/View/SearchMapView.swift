//
//  SearchMapView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 13/10/24.
//

import SwiftUI

import SwiftUI
import MapKit

struct SearchMapView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    @Binding var searchResults: [SearchResult]

     var body: some View {
         VStack {
             HStack {
                 Image(systemName: "magnifyingglass")
                 TextField("Search for a restaurant", text: $search)
                     .autocorrectionDisabled()
                     // 2
                     .onSubmit {
                         Task {
                             searchResults = (try? await locationService.search(with: search)) ?? []
                         }
                     }
             }
             .modifier(TextFieldGrayBackgroundColor())

             Spacer()

             List {
                 ForEach(locationService.completions) { completion in
                     // 3
                     Button(action: { didTapOnCompletion(completion) }) {
                         VStack(alignment: .leading, spacing: 4) {
                             Text(completion.title)
                                 .font(.headline)
                                 .fontDesign(.rounded)
                             Text(completion.subTitle)
                             // What can we show?
                             if let url = completion.url {
                                 Link(url.absoluteString, destination: url)
                                     .lineLimit(1)
                             }
                         }
                     }
                     .listRowBackground(Color.clear)
                 }
             }
             .listStyle(.plain)
             .scrollContentBackground(.hidden)
         }
         .onChange(of: search) {
             locationService.update(queryFragment: search)
         }
         .padding()
         .interactiveDismissDisabled()
         .presentationDetents([.height(200), .large])
         .presentationBackground(.regularMaterial)
         .presentationBackgroundInteraction(.enabled(upThrough: .large))
     }

     // 4
     private func didTapOnCompletion(_ completion: SearchCompletions) {
         Task {
             if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                 searchResults = [singleLocation]
             }
         }
     }
}


struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}

#Preview {
    struct Preview: View {
        @State var searchResults :[SearchResult] = []
        var body: some View {
            SearchMapView(searchResults: $searchResults)
        }
    }

    return Preview()
}
