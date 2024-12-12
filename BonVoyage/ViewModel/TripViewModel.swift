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
    @Published var competitors: [Competitor] = [] // deve essere sempre aggiornata
    var startDate: String?
    var endDate: String?
    var destinationName: String?
    
    //TODO: nuova gestione avatar come dictionary nomeavatar:isused
    var avatars: [String] = ["character1", "character2", "character3", "character4", "character5", "character6","character7", "character8",
    "character9", "character10"]
    
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
        // Rimuovi il competitor dalla lista in memoria
        self.competitors.removeAll(where: { $0.id == competitor.id })

        // Trova il CompetitorEntity corrispondente e rimuovilo da CoreData
        let request: NSFetchRequest<CompetitorEntity> = CompetitorEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", competitor.id as CVarArg)
        
        do {
            let competitorEntities = try context.fetch(request)
            for entity in competitorEntities {
                context.delete(entity)
            }
            saveContext()
            loadCompetitors()
        } catch {
            print("Errore durante la rimozione del competitor: \(error)")
        }
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
    
    func competitorEntitiesToCompetitors(_ competitorEntities: [CompetitorEntity]) -> [Competitor] {
        return competitorEntities.map { competitorEntity in
            Competitor(
                id: competitorEntity.id ?? UUID(),
                name: competitorEntity.name ?? "",
                points: competitorEntity.points,
                itemsPerDay: competitorEntity.itemsPerDay, 
                image: competitorEntity.image ?? ""
            )
        }
    }

    
    func saveCompetitorsToCoreData() {
        let competitorEntities = competitorsToCompetitorEntities()
        for competitorEntity in competitorEntities {
            trip?.addToCompetitors(competitorEntity)
        }
        saveContext()
    }
    
    func addCompetitorEntity(name: String, image: String) {
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
        competitors.removeAll()
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
    
    func updateCompetitorPoints(competitorId: UUID, newPoints: Int) {
        // Trova il competitor nella lista in memoria e aggiorna i suoi punti
        if let index = competitors.firstIndex(where: { $0.id == competitorId }) {
            competitors[index].points = Int16(newPoints)
            
            // Trova il CompetitorEntity corrispondente e aggiorna i suoi punti in CoreData
            let request: NSFetchRequest<CompetitorEntity> = CompetitorEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", competitorId as CVarArg)
            
            do {
                let competitorEntities = try context.fetch(request)
                for entity in competitorEntities {
                    entity.points = Int16(newPoints)
                }
                saveContext() // Salva le modifiche in CoreData
            } catch {
                print("Errore durante l'aggiornamento dei punti del competitor: \(error)")
            }
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
