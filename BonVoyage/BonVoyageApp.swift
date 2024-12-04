//
//  BonVoyageApp.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 13/10/24.
//

import SwiftUI

@main
struct BonVoyageApp: App {
    // Add this to your SwiftUI app's initialization
    init() {
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   - \(name)")
            }
        }
    }
    
    var body: some Scene {
        
        WindowGroup {
            MainView()
        }
    }
}
