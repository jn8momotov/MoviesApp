//
//  CoreDataManager.swift
//  MoviesApp
//
//  Created by Евгений on 24/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var savedMovies: [SaveMovie] {
        let fetchRequest: NSFetchRequest<SaveMovie> = SaveMovie.fetchRequest()
        if let array = try? managedObjectContext.fetch(fetchRequest) {
            return array
        }
        return []
    }
    
    func isSaved(movie: Movie) -> Bool {
        let fetchRequest: NSFetchRequest<SaveMovie> = SaveMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=\(movie.id)")
        if let count = try? managedObjectContext.fetch(fetchRequest).count, count > 0 {
            return true
        }
        return false
    }
    
    func save(movie: Movie, image data: Data?) {
        let newMovie = SaveMovie(context: managedObjectContext)
        newMovie.id = movie.id
        newMovie.title = movie.title
        newMovie.genres = movie.getGenres()
        newMovie.tagline = movie.tagline
        newMovie.releaseDate = movie.releaseDate
        newMovie.voteAverage = movie.voteAverage
        if let data = data {
            newMovie.poster = NSData(data: data)
        }
        newMovie.overview = movie.overview
        newMovie.language = movie.language
        newMovie.popularity = movie.popularity!
        newMovie.adult = movie.adult!
        newMovie.budget = movie.budget!
        newMovie.revenue = movie.revenue!
        newMovie.runtime = movie.runtime!
        newMovie.productions = movie.getProductionCompanies()
        saveContext()
    }
    
    func remove(movie: SaveMovie) {
        managedObjectContext.delete(movie)
        saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
