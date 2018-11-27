//
//  Services.swift
//  MoviesApp
//
//  Created by Евгений on 22/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//

import Foundation

class Services {
    
    private let apiKey = "c188f5c954cf80058fc27ad30a7b3c28"
    
    static let sharedInstance = Services()
    
    var searchPage = 0
    var populatePage = 0
    
    var populateMovies: [Movie] = []
    var searchMovies: [Movie] = []
    
    func loadMovies(completion: @escaping () -> Void) {
        populatePage += 1
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ru-RU&page=\(populatePage)")
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url!) { (data, responce, error) in
            if let data = data {
                self.populateMovies += self.getMovies(from: data)
                completion()
            }
        }
        dataTask.resume()
    }
    
    func loadMovies(search text: String, completion: @escaping () -> Void) {
        searchPage += 1
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=ru-RU&query=\(text)&page=\(searchPage)"
        guard let urlQueryString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let url = URL(string: urlQueryString)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url!) { (data, responce, error) in
            if let data = data {
                self.searchMovies += self.getMovies(from: data)
                completion()
            }
        }
        dataTask.resume()
    }
    
    func loadMovie(for movie: Movie, completion: @escaping () -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=\(apiKey)&language=ru-RU")
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url!) { (data, responce, error) in
            if let data = data {
                self.parseDetailMovie(movie, with: data)
                completion()
            }
        }
        dataTask.resume()
    }
    
    func parseDetailMovie(_ movie: Movie, with data: Data) {
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            print("Error serialization!")
            return
        }
        if let dictionary = dict as? Dictionary<String, Any> {
            movie.initDetailInfo(dictionary: dictionary)
        }
    }
    
    func loadImage(for movie: Movie, completion: @escaping (Data) -> Void) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url!) { (data, responce, error) in
            if let data = data {
                completion(data)
            }
        }
        dataTask.resume()
    }
    
    func getMovies(from data: Data) -> [Movie] {
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            print("Error serialization!")
            return []
        }
        if let dictionary = dict as? Dictionary<String, Any>, let arrayMovies = dictionary["results"] as? [Dictionary<String, Any>] {
            var array: [Movie] = []
            for movie in arrayMovies {
                let newMovie = Movie(dictionary: movie)
                array.append(newMovie)
            }
            return array
        }
        return []
    }
    
}
