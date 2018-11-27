//
//  MoviesController.swift
//  MoviesApp
//
//  Created by Евгений on 22/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

class MoviesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Services.sharedInstance.loadMovies {
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
        return Services.sharedInstance.populateMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movie = Services.sharedInstance.populateMovies[indexPath.row]
        cell.initCell(for: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == Services.sharedInstance.populateMovies.count - 1 {
            Services.sharedInstance.loadMovies {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let controller = segue.destination as! DetailMovieController
            if let selectedIndex = tableView.indexPathForSelectedRow?.row {
                let movie = Services.sharedInstance.populateMovies[selectedIndex]
                controller.movie = movie
            }
        }
    }

}
