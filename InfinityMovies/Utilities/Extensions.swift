//
//  Extensions.swift
//  InfinityMovies
//
//  Created by Andrew Masters on 12/4/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    /*
     UIImageView extension to download a image given the end path of the image.
     Code taken from user Leo Dabus @ the following address
     https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
     */
    
    func downloadImg(from poster_path: String, contentMode mode: ContentMode = .scaleAspectFit) {
        let url_path = "https://image.tmdb.org/t/p/w500/\(poster_path)"
        guard let url = URL(string: url_path) else { return }
        download(from: url, contentMode: mode)
    }
    
    private func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
