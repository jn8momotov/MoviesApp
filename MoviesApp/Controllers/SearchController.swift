//
//  SearchController.swift
//  MoviesApp
//
//  Created by Евгений on 26/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Services.sharedInstance.searchMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchMovieCell", for: indexPath)
        cell.textLabel?.text = Services.sharedInstance.searchMovies[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == Services.sharedInstance.searchMovies.count - 1 {
            guard let textSearch = searchBar.text else {
                return
            }
            Services.sharedInstance.loadMovies(search: textSearch) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let controller = segue.destination as! DetailMovieController
            if let selectedIndex = tableView.indexPathForSelectedRow?.row {
                let movie = Services.sharedInstance.searchMovies[selectedIndex]
                controller.movie = movie
            }
        }
    }

}

extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            Services.sharedInstance.searchPage = 0
            Services.sharedInstance.searchMovies = []
            Services.sharedInstance.loadMovies(search: searchText) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
