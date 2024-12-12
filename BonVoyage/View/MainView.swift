//
//  MainView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import SwiftUI

struct MainView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            TabView {
                NavigationView {
                    ContentView()
                }.tabItem {
                    Label("Viaggio", systemImage: "airplane")
                    
                }
                
                NavigationView {
                    RulesView()
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
        // splashScreen
        else {
            SplashScreen(isActive: $isActive)
        }
    }
}

#Preview {
    MainView()
}
