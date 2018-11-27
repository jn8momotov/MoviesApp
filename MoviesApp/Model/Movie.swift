//
//  Movie.swift
//  MoviesApp
//
//  Created by Евгений on 22/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import Foundation

class Movie {
    
    var id: Int32
    var title: String
    var releaseDate: String
    var voteAverage: Double
    var voteCount: Int
    var posterPath: String
    
    var overview: String?
    var language: String?
    var popularity: Double?
    var adult: Bool?
    var budget: Int32?
    var revenue: Int32?
    var runtime: Int32?
    var tagline: String?
    var genres: [String]?
    var productionCompanies: [String]?
    
    func getGenres() -> String {
        return genres!.joined(separator: ", ")
    }
    
    func getProductionCompanies() -> String {
        return productionCompanies!.joined(separator: ", ")
    }
    
    init(dictionary: Dictionary<String, Any>) {
        id = dictionary["id"] as? Int32 ?? 0
        title = dictionary["title"] as? String ?? ""
        releaseDate = dictionary["release_date"] as? String ?? ""
        voteAverage = dictionary["vote_average"] as? Double ?? 0.0
        posterPath = dictionary["poster_path"] as? String ?? ""
        voteCount = dictionary["vote_count"] as? Int ?? 0
    }
    
    func initDetailInfo(dictionary: Dictionary<String, Any>) {
        adult = dictionary["adult"] as? Bool ?? false
        budget = dictionary["budget"] as? Int32 ?? 0
        revenue = dictionary["revenue"] as? Int32 ?? 0
        runtime = dictionary["runtime"] as? Int32 ?? 0
        tagline = dictionary["tagline"] as? String ?? ""
        overview = dictionary["overview"] as? String ?? ""
        language = dictionary["original_language"] as? String ?? ""
        popularity = dictionary["popularity"] as? Double ?? 0.0
        genres = []
        if let genresDict = dictionary["genres"] as? [Dictionary<String, Any>] {
            for genre in genresDict {
                let newGenre = genre["name"] as? String ?? ""
                genres!.append(newGenre)
            }
        }
        productionCompanies = []
        if let companies = dictionary["production_companies"] as? [Dictionary<String, Any>] {
            for company in companies {
                let nameCompany = company["name"] as? String ?? ""
                productionCompanies!.append(nameCompany)
            }
        }
    }
    
}
