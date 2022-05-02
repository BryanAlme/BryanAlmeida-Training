//
//  ListMovieCoerData.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 30/04/2022.

import Foundation
import CoreData

class ListMovieCore{
    static var context:NSManagedObjectContext {
        let container = NSPersistentContainer(name: "MovieDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        let context = container.viewContext
        return context
    }
}
