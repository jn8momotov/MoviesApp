//
//  SavedMoviesController.swift
//  MoviesApp
//
//  Created by Евгений on 27/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

class SavedMoviesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("NewSavedMovie"), object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.sharedInstance.savedMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedMovieCell", for: indexPath) as! MovieCell
        let movie = CoreDataManager.sharedInstance.savedMovies[indexPath.row]
        cell.initCell(savedMovie: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = CoreDataManager.sharedInstance.savedMovies[indexPath.row]
            CoreDataManager.sharedInstance.remove(movie: movie)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }   
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let controller = segue.destination as! DetailMovieController
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let savedMovie = CoreDataManager.sharedInstance.savedMovies[selectedIndex]
            controller.savedMovie = savedMovie
        }
    }

}
