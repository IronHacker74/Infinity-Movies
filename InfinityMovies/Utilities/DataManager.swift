//
//  DataManager.swift
//  InfinityMovies
//
//  Created by Andrew Masters on 12/4/21.
//

/*
 An object to download data from the API and to create objects, sending them
 back to the controllers.
 */

import Foundation
import UIKit

class DataManager {
    
    private let apiBaseURL: String! = "https://api.themoviedb.org/3/"
    
    private func getAPIKey() -> String {
        // Code Found by Caleb @
        // https://stackoverflow.com/questions/31778700/read-a-text-file-line-by-line-in-swift
        
        if let path = Bundle.main.path(forResource: "APIKEY", ofType: "txt") {
            do {
                let key = try String(contentsOfFile: path, encoding: .utf8)
                return key
            } catch {
                print("Could not read from APIKEY.txt")
            }
        }
        return "'noapikey'"
    }
    
    private func downloadData(_ url_path: String, completion: @escaping ([String : AnyObject]) -> Void){
        print("Making Web Request to: \(url_path)")
        
        // Code partially taken from user david72 @
        // https://stackoverflow.com/questions/24065536/downloading-and-parsing-json-in-swift
        
        URLSession.shared.dataTask(with: URL(string: url_path)!) { (data, response, error) in
            
            let status = response as? HTTPURLResponse
            print("Response: \(status?.statusCode ?? -1)")
            if error == nil && data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                    completion(json!)
                } catch {
                    print("Could not parse JSON")
                    completion([:])
                }

            } else {
                print(error!)
            }

        }.resume()
    }
    
    
    func downloadSearchedMovies(_ query: String, with page: Int, completion: @escaping ([MovieTableData]) -> Void){
        let searchString = query.replacingOccurrences(of: " ", with: "%20")
        
        let apiparam = "search/movie?api_key=\(getAPIKey())&query=\(searchString)&page=\(page)"
        let url_path = apiBaseURL + apiparam
        
        downloadData(url_path, completion: { parsedJSON in
            if let results = parsedJSON["results"] as? [[String : AnyObject]] {
                if results.isEmpty {
                    completion([])
                    return
                }
                
                let numberOfResults = results.count
                var movies = [MovieTableData]()
                
                for index in 0...numberOfResults-1 {
                    movies.append(MovieTableData(results[index]))
                }
                completion(movies)
                
            } else {
                print("JSON could not find 'results'")
                completion([])
            }
        })
    }
    
    
    
}

