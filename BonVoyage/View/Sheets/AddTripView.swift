//
//  AddTripView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import SwiftUI

struct AddTripView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @Binding var isShowingSheet: Bool
    
    @State private var destination: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()

    var body: some View {
        
        Form {
            AddTripInfoCard(destination: $destination, initialDate: $startDate, finalDate: $endDate)
            AddCompetitorsListCard().environment(tripViewModel)
        }
        .toolbar {
            ToolbarItem(placement: .principal)
            {
                Text("Scheda viaggio")
                    .customFont()
            }
            
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button("Salva") {
                    tripViewModel.setDestination(destination)
                    tripViewModel.setFinalDate(endDate)
                    tripViewModel.setInitialDate(startDate)
                    tripViewModel.createTrip()
                    isShowingSheet.toggle()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading)
            {
                Button("Annulla") {
                    isShowingSheet.toggle()
                }
            }
        }
    }
}


struct AddTripInfoCard: View {
    @Binding var destination: String
    @Binding var initialDate: Date
    @Binding var finalDate: Date
    @EnvironmentObject var tripViewModel: TripViewModel

    
    var body: some View {
        
        Section {
            TextField("Nome del Viaggio", text: $destination)
                        .padding(.vertical, 10.0)
                
            DatePicker ("Inizio viaggio", selection: $initialDate, displayedComponents: .date)
                    .foregroundColor(.white)
                
            DatePicker ("Termine viaggio", selection: $finalDate, displayedComponents: .date)
                    .padding(.bottom)
                    .foregroundColor(.white)
        }
        .listRowBackground(Color.teal)
                       .fontWeight(.medium)
                       .clipShape(RoundedRectangle(cornerRadius: 10))
    }

}


struct AddCompetitorsListCard: View {
    @State private var competitorName: String = ""
    @EnvironmentObject var tripViewModel: TripViewModel

    var body: some View {
        Section {
            VStack {
                Text("Aggiungi i Concorrenti")
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
                    .foregroundColor(.white)
                
                HStack {
                    TextField("Nome del Concorrente", text: $competitorName)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 5)
                    
                    AddButtonView(action: {
                        
                        tripViewModel.setShuffledAvatars()
                        let competitorsCount = tripViewModel.competitorsCount
                        let avatar = tripViewModel.getShuffledAvatar(competitorsCount)
                        
                        if !competitorName.isEmpty {
                            tripViewModel.addCompetitor(Competitor(name: competitorName, points: 0, itemsPerDay: 0, image: avatar))
                        }
                        
                        self.competitorName.removeAll()
                    })
                    
                }
            }
            if let competitors = tripViewModel.getCompetitors() {
                
                List {
                    ForEach(competitors, id: \.self) { competitor in
                        CompetitorCard(image: competitor.image, name: competitor.name)
                    }
                    .onDelete { indexSet in
                        tripViewModel.competitors.remove(atOffsets: indexSet)
                    }
                }
            }
        }
         .listRowBackground(Color.teal)
                        .fontWeight(.medium)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


//#Preview {
//    AddTripView(viewModel: <#TripViewModel#>, isShowingSheet: .constant(true))
//}
