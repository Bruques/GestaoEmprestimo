//
//  CoreDataStack.swift
//  GestaoEmprestimo
//
//  Created by Bruno Marques on 07/02/25.
//

import Foundation
import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GestaoEmprestimoModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private init() {}
}

extension CoreDataStack {
    func save() {
        guard persistentContainer.viewContext.hasChanges else { return }
        do {
            try persistentContainer.viewContext.save()
            print("Salvo com sucesso!")
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
}
