//
//  DataController.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 08/11/24.
//

import CoreData

struct DataController {
    static let shared = DataController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DataModel") // Assicurati che il nome corrisponda al tuo file .xcdatamodeld
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                // Gestisci l'errore in base alle tue esigenze
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

