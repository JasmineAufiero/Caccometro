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
                    .navigationBarTitle("Viaggio", displayMode: .large)
            }.tabItem {
                Label("Viaggio", systemImage: "airplane")
            }
            
            NavigationView {
                RulesView()
                    .navigationBarTitle("Regolamento", displayMode: .large)
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
