//
//  SingleMovieData.swift
//  InfinityMovies
//
//  Created by Andrew Masters on 12/4/21.
//

/*
 Single Movie Data object initiated by downloading a single movie from the API
 given it's id.
 */

import Foundation

class SingleMovieData {
    var tagline: String
    var bgImg_path: String
    var description: String
    
    init(_ movieData: [String : AnyObject]){
        if let backdrop_path = movieData["backdrop_path"] as? String {
            bgImg_path = backdrop_path
        } else {
            bgImg_path = "'no path'"
        }
        if let movie_tagline = movieData["tagline"] as? String {
            tagline = movie_tagline
        } else {
            tagline = "'No tagline found'"
        }
        if let movie_description = movieData["overview"] as? String {
            description = movie_description
        } else {
            description = "'no description found'"
        }
    }
}
