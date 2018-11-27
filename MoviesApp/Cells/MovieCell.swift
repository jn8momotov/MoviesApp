//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Евгений on 22/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    func initCell(for movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.voteAverage)/10.0"
        releaseDateLabel.text = movie.releaseDate
    }
    
    func initCell(savedMovie: SaveMovie) {
        titleLabel.text = savedMovie.title
        ratingLabel.text = "Rating: \(savedMovie.voteAverage)/10.0"
        releaseDateLabel.text = savedMovie.releaseDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
