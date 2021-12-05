//
//  MovieInfoVC.swift
//  InfinityMovies
//
//  Created by Andrew Masters on 12/4/21.
//

import Foundation
import UIKit

class MovieInfoVC: UIViewController {
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tagLineLbl: UILabel!
    
    let dataManager = DataManager()
    var dispatch_group = DispatchGroup()
    var moviePoster: UIImage!
    var movieTitle: String!
    var movieID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = movieTitle
        posterImg.image = moviePoster
        
        dispatch_group.enter()
        dataManager.downloadSingleMovieData(movieID, completion: { movieData in
            self.dispatch_group.leave()
            
            self.dispatch_group.notify(queue: .main, execute: {
                self.descriptionTV.text = "Description: \(movieData.description)"
                self.tagLineLbl.text = "Tagline: \(movieData.tagline)"
                self.bgImg.downloadImg(from: movieData.bgImg_path)
            })
        })
    }
}
