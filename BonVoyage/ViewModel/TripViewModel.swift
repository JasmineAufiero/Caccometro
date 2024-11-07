//
//  AddCompetitorsViewModel.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import Foundation
    
class TripViewModel: ObservableObject, Observable {
    
    @Published var trip: Trip?
    @Published var competitors: [Competitor] = []
    var startDate: String?
    var endDate: String?
    var destinationName: String?
    
    var avatars: [String] = ["character1", "character2", "character3", "character4", "character5"]
    
    var shuffledAvatars : [String] = []
    
    var competitorsCount :Int {
        self.competitors.count
    }
    
    func addCompetitor(_ competitor: Competitor) {
        self.competitors.append(competitor)
    }
    
    func removeCompetitor(_ competitor: Competitor) {
        self.competitors.removeAll(where: { $0.id == competitor.id })
    }
    
    func removeCompetitor(at offset: IndexSet) {
        self.competitors.remove(atOffsets: offset)
    }
    
    func removeAllCompetitors() {
        self.competitors.removeAll()
    }
    
    func removeTrip() {
        if trip != nil {
            self.trip = nil
        }
    }
    
    func createTrip() {
        trip = Trip(destination: destinationName, initialDate: startDate, finalDate: endDate, competitors: competitors)
    }
    
    func loadTrip() {
        // quando esisterà un BE, controlliamo che esista qua.
    }
        
    func setDestination(_ destination: String) {
        self.destinationName = destination
    }
        
    func getDestination() -> String {
        return trip?.destination ?? ""
    }
        
    func setInitialDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startDate = dateFormatter.string(from: date)
    }
        
    func setFinalDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        endDate = dateFormatter.string(from: date)
    }
        
    func getInitialDate() -> Date {
        if let date = trip?.initialDate {
            return DateFormatter().date(from: date) ?? Date()
        }
        else { return Date() }
    }
        
    func getFinalDate() -> Date {
        if let date = trip?.finalDate {
            return DateFormatter().date(from: date) ?? Date()
        }
        else { return Date() }
    }
        
    func getCompetitors() -> [Competitor]? {
        return competitors
    }
        
    func getAvatars() -> [String] {
        return avatars
    }
        
    func getShuffledAvatar(_ index: Int) -> String {
        return shuffledAvatars[index]
    }
        
    func setShuffledAvatars() {
        if competitors.isEmpty {
            shuffledAvatars = avatars.shuffled()
        }
    }
 
}
