//
//  MovieListVC.swift
//  InfinityMovies
//
//  Created by Andrew Masters on 12/3/21.
//

import UIKit

class MovieListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dispatch_group = DispatchGroup()
    let dataManager = DataManager()
    var listOfMovies = [MovieTableData]()
    
    var selectedMovie: MovieTableData!
    var selectedPosterImg: UIImage!
    
    var isDownloading: Bool = false
    var pageNumber: Int = 1
    var currentSearch: String = "movie search"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set TableView
        tableView.dataSource = self
        tableView.delegate = self
        
        //Set SearchBar
        searchBar.delegate = self
        
        //Download first-seeing movies
        currentSearch = "movies"
        downloadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Send selected movieCell to MovieInfoVC
        if segue.identifier == "movieDetailsSegue" {
            let destination = segue.destination as! MovieInfoVC
            destination.movieID = selectedMovie.id
            destination.movieTitle = selectedMovie.title
            destination.moviePoster = selectedPosterImg
        }
    }
    

    //Call dataManager and download movies with 'currentSearch' and 'pageNumber'
    func downloadMovies(){
        dispatch_group.enter()
        isDownloading = true
        
        dataManager.downloadSearchedMovies(currentSearch, with: pageNumber, completion: {results in
            self.dispatch_group.leave()
            self.isDownloading = false
            
            self.dispatch_group.notify(queue: .main, execute: {
                if(results.count < 20){
                    self.isDownloading = true
                    
                    if(results.isEmpty){
                        print("Results empty - nothing added to listOfMovies")
                        return
                    }
                }
                self.listOfMovies += results
                self.tableView.reloadData()
            })
        })
    }

}



//MARK: - TableView list of movies
extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //If we have seen everything in listOfMovies except 6 elements and
        // nothing is currently being downloaded, increase the pageNumber and download again
        if(indexPath.row > listOfMovies.count-6 && !isDownloading){
            pageNumber += 1
            downloadMovies()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell {
            cell.configure(listOfMovies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select the cell and segue to MovieInfoVC
        let cell = self.tableView.cellForRow(at: indexPath) as? MovieCell
        selectedPosterImg = cell?.posterImg.image
        selectedMovie = listOfMovies[indexPath.row]
        performSegue(withIdentifier: "movieDetailsSegue", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}



//MARK: - SearchBar
extension MovieListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(validSearch(searchBar.text!)){
            listOfMovies.removeAll()
            tableView.reloadData()
            
            pageNumber = 1
            currentSearch = searchBar.text!
            downloadMovies()
        }
    }
    
    func validSearch(_ text: String) -> Bool{
        if(text.isEmpty || text.replacingOccurrences(of: " ", with: "") == ""){
            return false
        }
        return true
    }
}
