//
//  ContentView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 13/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var tripViewModel = TripViewModel()
    @State private var isShowingSheet = false
    var body: some View {
        
        NavigationView {
            if tripViewModel.trip != nil {
                VStack {
                    // Aggiungere classifica con button di modifica viaggio e aggiungi nuovo viaggio (rimuovendo quello attualmente creato)
                    RankingView().environmentObject(tripViewModel)
                }
            }
            else {
                NoTripsYet(isShowingSheet: $isShowingSheet)
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            NavigationStack {
                AddTripView(isShowingSheet: $isShowingSheet)
                    .environmentObject(tripViewModel)
            }
        }.environmentObject(tripViewModel)
    }
}

struct NoTripsYet: View {
    @Binding var isShowingSheet: Bool
    @EnvironmentObject var tripViewModel: TripViewModel
    
    var body: some View {
        
        VStack {
            if let image = UIImage(named: "fillerViaggi") {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .padding(.bottom, 20.0)
                
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Text("Aggiungi il tuo viaggio")
                        .foregroundColor(.white)
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.teal)
                        .cornerRadius(8)
                }
                
//                NavigationLink(destination: AddTripView()) {
//                    Text("Aggiungi il tuo viaggio")
//                        .foregroundColor(.white)
//                        .padding()
//                        .fontWeight(.bold)
//                        .background(Color.teal)
//                        .cornerRadius(8)
//                }
            }
        }
    }
}


#Preview {
    ContentView()
}
