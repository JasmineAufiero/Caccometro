//
//  AddCompetitorsViewModel.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import Foundation
import CoreData

class TripViewModel: ObservableObject, Observable {
    
    @Published var trip: TripEntity?
    @Published var competitors: [Competitor] = []
    var startDate: String?
    var endDate: String?
    var destinationName: String?
    
    var avatars: [String] = ["character1", "character2", "character3", "character4", "character5"]
    
    var shuffledAvatars : [String] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        loadTrip()
    }
    
    var competitorsCount : Int {
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
    
    func removeCompetitor(_ competitor: CompetitorEntity) {
        context.delete(competitor)
        saveContext()
        loadCompetitors()
    }
    
    func removeAllCompetitors() {
        self.competitors.removeAll()
    }
    
    func competitorsToCompetitorEntities() -> [CompetitorEntity] {
        competitors.map { competitor in
            let entity = CompetitorEntity(context: context)
            entity.id = competitor.id
            entity.name = competitor.name
            entity.image = competitor.image
            entity.itemsPerDay = competitor.itemsPerDay ?? 0
            entity.points = competitor.points ?? 0
            entity.trip = trip
            return entity
        }
    }
    
    func saveCompetitorsToCoreData() {
        let competitorEntities = competitorsToCompetitorEntities()
        for competitorEntity in competitorEntities {
            trip?.addToCompetitors(competitorEntity)
        }
        saveContext()
    }
    
    func addCompetitor(name: String, image: String) {
        let newCompetitor = Competitor(id: UUID(), name: name, image: image)
        competitors.append(newCompetitor)
        saveCompetitorsToCoreData()
        loadCompetitors() // Ricarica i competitori per aggiornare l'interfaccia utente
    }
    
    func loadCompetitors() {
        guard let trip = trip else { return }
        let request: NSFetchRequest<CompetitorEntity> = CompetitorEntity.fetchRequest()
        request.predicate = NSPredicate(format: "trip == %@", trip)
        
        do {
            let competitorEntities = try context.fetch(request)
            self.competitors = competitorEntities.map { competitorEntity in
                Competitor(id: competitorEntity.id ?? UUID(), name: competitorEntity.name ?? "", image: competitorEntity.image ?? "")
            }
        } catch {
            print("Errore durante il caricamento dei competitori da CoreData: \(error)")
        }
    }
        
    func createTrip() {
        let newTrip = TripEntity(context: context)
        newTrip.destination = destinationName
        newTrip.initialDate = startDate
        newTrip.finalDate = endDate
        // Converte i Competitors in CompetitorEntities e li aggiunge al nuovo trip
        let competitorEntities = competitorsToCompetitorEntities()
        
        for competitorEntity in competitorEntities {
            newTrip.addToCompetitors(competitorEntity)
            competitorEntity.trip = newTrip
        }
        saveContext()
        trip = newTrip
    }
    
    func updateTrip(destination: String?, initialDate: String?, finalDate: String?) {
        guard let trip = trip else { return }
        
        if let destination = destination {
            trip.destination = destination
        }
        if let initialDate = initialDate {
            trip.initialDate = initialDate
        }
        if let finalDate = finalDate {
            trip.finalDate = finalDate
        }
        saveContext()
    }
    
    func removeTrip() {
        if let trip = trip {
            context.delete(trip)
            saveContext()
            self.trip = nil
        }
    }

    func loadTrip() {
        let request: NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        
        do {
            let trips = try context.fetch(request)
            if let existingTrip = trips.first {
                self.trip = existingTrip
                loadCompetitors()  // Carica i competitori associati
            }
        } catch {
            print("Errore durante il caricamento dei viaggi da CoreData: \(error)")
        }
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
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Errore durante il salvataggio del contesto: \(error)")
        }
    }
}
