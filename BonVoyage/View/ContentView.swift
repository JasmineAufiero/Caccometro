//
//  ContentView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 13/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var tripViewModel: TripViewModel
    @State private var isShowingSheet = false
    
    init() { let context = DataController.shared.container.viewContext
        _tripViewModel = StateObject(wrappedValue: TripViewModel(context: context)) }
    
    var body: some View {
        
        Section {
            if tripViewModel.trip != nil {
                // Aggiungere classifica con button di modifica viaggio e aggiungi nuovo viaggio (rimuovendo quello attualmente creato)
                RankingView(tripViewModel: tripViewModel)
                    .environmentObject(tripViewModel)
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
        }
    }
}

struct NoTripsYet: View {
    @Binding var isShowingSheet: Bool
    @EnvironmentObject var tripViewModel: TripViewModel
    
    var body: some View {
        
        VStack {
            Text("Viaggio")
                .customFont()
                .navigationBarTitleDisplayMode(.large)
            
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


//#Preview {
//    ContentView()
//}
