//
//  MainView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            NavigationView {
                ContentView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Viaggio").font(.title).fontWeight(.semibold)
                            }
                        }
                    }
            }.tabItem {
                    Label("Viaggio", systemImage: "airplane")
                }

            NavigationView {
                RulesView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Regolamento").font(.title).fontWeight(.semibold)
                            }
                        }
                    }
            }
            .tabItem {
                    Label("Regolamento", systemImage: "book.pages")
                }
            
//            MapsView()
//                .tabItem {
//                Label("Mappa", systemImage: "map")
//            }
        }
    }
}

#Preview {
    MainView()
}
