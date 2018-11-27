//
//  DetailMovieController.swift
//  MoviesApp
//
//  Created by Евгений on 23/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

class DetailMovieController: UITableViewController {
    
    var movie: Movie?
    var savedMovie: SaveMovie?
    
    var loadingView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var isAdultImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var prodictionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            detailInfoSavedMovie()
            return
        }
        showLoadingView()
        Services.sharedInstance.loadMovie(for: movie) {
            DispatchQueue.main.async {
                self.updateDetailInfo()
                self.removeLoadingView()
            }
        }
        Services.sharedInstance.loadImage(for: movie) { (dataImage) in
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: dataImage)
            }
        }
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        guard CoreDataManager.sharedInstance.isSaved(movie: movie!) else {
            CoreDataManager.sharedInstance.save(movie: movie!, image: posterImageView.image?.pngData())
            showSaveMovieAlertController()
            NotificationCenter.default.post(name: NSNotification.Name("NewSavedMovie"), object: nil)
            return
        }
        showErrorAlertController()
    }
    
    func showErrorAlertController() {
        let alertController = UIAlertController(title: "This movie been saved!", message: nil, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showSaveMovieAlertController() {
        let alertController = UIAlertController(title: "Saved movie!", message: nil, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingView() {
        loadingView = UIView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = UIColor.white
        self.tableView.isScrollEnabled = false
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = loadingView.center
        activityView.startAnimating()
        loadingView.addSubview(activityView)
        view.addSubview(loadingView)
    }
    
    func removeLoadingView() {
        loadingView.removeFromSuperview()
        tableView.isScrollEnabled = true
    }
    
    func updateDetailInfo() {
        titleLabel.text = movie!.title
        taglineLabel.text = movie!.tagline
        overviewText.text = movie!.overview
        languageLabel.text = movie!.language
        runtimeLabel.text = "\(movie!.runtime!)"
        popularityLabel.text = "\(movie!.popularity!)"
        budgetLabel.text = "\(movie!.budget!)"
        revenueLabel.text = "\(movie!.revenue!)"
        genresLabel.text = movie!.getGenres()
        prodictionsLabel.text = movie!.getProductionCompanies()
        if movie!.adult! {
            isAdultImageView.image = UIImage(named: "adult")
        }
    }
    
    func detailInfoSavedMovie() {
        titleLabel.text = savedMovie!.title
        taglineLabel.text = savedMovie!.tagline
        overviewText.text = savedMovie!.overview
        languageLabel.text = savedMovie!.language
        runtimeLabel.text = "\(savedMovie!.runtime)"
        popularityLabel.text = "\(savedMovie!.popularity)"
        budgetLabel.text = "\(savedMovie!.budget)"
        revenueLabel.text = "\(savedMovie!.revenue)"
        genresLabel.text = savedMovie!.genres
        prodictionsLabel.text = savedMovie!.productions
        if let imageData = savedMovie?.poster {
            posterImageView.image = UIImage(data: imageData as Data)
        }
        if savedMovie!.adult {
            isAdultImageView.image = UIImage(named: "adult")
        }
    }

}
