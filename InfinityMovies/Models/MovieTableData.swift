//
//  MovieTableData.swift
//  InfinityMovies
//
//  Created by Andrew Masters on 12/4/21.
//

/*
 Movie Table Object that will be used to store data downloaded from /search/movie
 from 'The Movie Database API'.
 */
import Foundation

class MovieTableData {
    var id: String
    var title: String
    var votes: Int
    var poster_path: String
    var release_date: String
    
    // Takes Dictionary as Object and parses out the information we ant to fill our movie object
    init(_ movieData: [String : AnyObject]){
        if let movieid = movieData["id"] as? Int {
            self.id = "\(movieid)"
        } else {
            self.id = "-1"
        }
        if let movieTitle = movieData["title"] as? String {
            self.title = movieTitle
        } else {
            self.title = "title unknown"
        }
        if let movieVotes = movieData["vote_count"] as? Int {
            self.votes = movieVotes
        } else {
            self.votes = 0
        }
        if let moviePosterURL = movieData["poster_path"] as? String {
            self.poster_path = moviePosterURL
        } else {
            self.poster_path = "no path"
        }
        if let movieRelease = movieData["release_date"] as? String {
            self.release_date = movieRelease
        } else {
            self.release_date = "00-00-0000"
        }
    }
    
}
