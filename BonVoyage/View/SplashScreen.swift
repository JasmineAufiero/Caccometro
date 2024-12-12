//
//  SplashScreen.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 12/12/24.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isActive: Bool
    @State var degreesRotating = 0.0
    
    var body: some View {
        ZStack {
            Image("vinile")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0)
                .edgesIgnoringSafeArea(.all)
            
            Text("Bon Voyage")
                .customFont(FontWeight.bold, 100)
                .foregroundColor(Color.white)
        }
        .rotationEffect(.degrees(degreesRotating))
        .onAppear {
                withAnimation(.linear(duration: 1)
                    .speed(0.3).repeatForever(autoreverses: false)) {
                        degreesRotating = 360.0
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            self.isActive = true
                        }
                }
        }
    }
}

//#Preview {
//    SplashScreen()
//}
