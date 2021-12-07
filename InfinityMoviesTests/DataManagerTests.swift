//
//  DataManagerTests.swift
//  InfinityMoviesTests
//
//  Created by Andrew Masters on 12/7/21.
//

/*
 Testing Functions in DataManager: Call individually in 'InfinityMoviesTests'
 This all tests the Models ('MovieTableData' and 'SingleMovieData') as they are
 generated after downloading in DataManager
 */

import XCTest
@testable import InfinityMovies

//Test with no id input
func testDataManagerDownloadSingleMovie_EMPTY() throws {
    //Test Object
    var downloadedObject: SingleMovieData!
    let dataManager = DataManager()

    dataManager.downloadSingleMovieData("", completion: {data in
        downloadedObject = data
        //Should be default description
        XCTAssertEqual(downloadedObject.description, "'no description found'")
    })
}

//Test an invalid id input
func testDataManagerDownloadSingleMovie_INVALID_ID() throws {
    //Test Object
    var downloadedObject: SingleMovieData!
    let dataManager = DataManager()

    dataManager.downloadSingleMovieData("-1", completion: {data in
        downloadedObject = data
        //Should be default description
        XCTAssertEqual(downloadedObject.description, "'no description found'")
    })
}


//Test for 'Teen Titans Go! To the Movies' w/ tagline: 'The superhero movie to end all superhero movies. Hopefully.'
func testDataManagerDownloadSingleMovie_GIVEN_ID() throws {
    var downloadedObject: SingleMovieData!
    let dataManager = DataManager()

    dataManager.downloadSingleMovieData("474395", completion: {data in
        downloadedObject = data
        //Should have the tagline
        XCTAssertEqual(downloadedObject.tagline, "The superhero movie to end all superhero movies. Hopefully.")
    })
}

//Test empty search
func testDataManagerDownloadMoviesSearched_EMPTY() throws {
    var movieArray = [MovieTableData]()
    let dataManager = DataManager()

    dataManager.downloadSearchedMovies("", with: 1, completion: { data in
        movieArray = data
        //Empty search should have movie array at 0
        XCTAssertEqual(movieArray.count, 0)
    })
}

func testDataManagerDownloadMoviesSearched_INVALID_SEARCH() throws {
    var movieArray = [MovieTableData]()
    let dataManager = DataManager()

    dataManager.downloadSearchedMovies(" 1!2djk28", with: 1, completion: { data in
        movieArray = data
        //Invalid search should have movieArray be empty
        XCTAssertEqual(movieArray.count, 0)
    })
}

//Test A search of a full results (20 items)
func testDataManagerDownloadMoviesSearched_SPECIFIC_SEARCH() throws {
    var movieArray = [MovieTableData]()
    let dataManager = DataManager()

    dataManager.downloadSearchedMovies("Teen Titans Go! To the Movies", with: 1, completion: { data in
        movieArray = data
        //This specific search should have movieArray only hold 1 movie
        XCTAssertEqual(movieArray.count, 1)
    })
}

//Test A search of a full results (20 items)
func testDataManagerDownloadMoviesSearched_FULL_SEARCH() throws {
    var movieArray = [MovieTableData]()
    let dataManager = DataManager()

    dataManager.downloadSearchedMovies("Iron Man", with: 1, completion: { data in
        movieArray = data
        //movieArray should hold 20 items
        XCTAssertEqual(movieArray.count, 20)
    })
}

//Test A search of a full results (20 items)
func testDataManagerDownloadMoviesSearched_INVALID_PAGE_NUMBER() throws {
    var movieArray = [MovieTableData]()
    let dataManager = DataManager()

    dataManager.downloadSearchedMovies("Iron Man", with: 931283, completion: { data in
        movieArray = data
        //Since the page number is at a ridiculous number, movieArray should not have any movies
        XCTAssertEqual(movieArray.count, 0)
    })
}
