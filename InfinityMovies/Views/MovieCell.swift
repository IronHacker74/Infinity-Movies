//
//  MovieCell.swift
//  InfinityMovies
//
//  Created by Andrew Masters on 12/4/21.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    
    func configure(_ movie: MovieTableData){
        titleLbl.text = movie.title
        releaseLbl.text! = "Released: \(movie.release_date)"
        ratingLbl.text! = "Votes: \(movie.votes)"
        
        //Add a question mark image until the other image downloads and is set
        posterImg.image = UIImage(systemName: "questionmark.app.fill")

        posterImg.downloadImg(from: movie.poster_path)
    }
    

}
