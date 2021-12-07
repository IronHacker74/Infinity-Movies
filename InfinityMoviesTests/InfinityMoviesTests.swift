//
//  InfinityMoviesTests.swift
//  InfinityMoviesTests
//
//  Created by Andrew Masters on 12/3/21.
//

import XCTest
@testable import InfinityMovies

class InfinityMoviesTests: XCTestCase {
    
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    func testExample() throws {}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            try? testDataManager()
        }
    }
    
    // Test DataManager - Previous test runtime: ~4 seconds
    func testDataManager() throws {
        try testDataManagerDownloadSingleMovie_EMPTY()
        try testDataManagerDownloadSingleMovie_INVALID_ID()
        try testDataManagerDownloadSingleMovie_GIVEN_ID()
        
        try testDataManagerDownloadMoviesSearched_EMPTY()
        try testDataManagerDownloadMoviesSearched_INVALID_SEARCH()
        try testDataManagerDownloadMoviesSearched_SPECIFIC_SEARCH()
        try testDataManagerDownloadMoviesSearched_FULL_SEARCH()
        try testDataManagerDownloadMoviesSearched_INVALID_PAGE_NUMBER()
    }
}




extension InfinityMoviesTests {
    //MovieListVC Tests
    
    func testSearchBarTextFromMovieListVC() throws {
        let movieListVC = MovieListVC()
        
        //empty
        var searchText: String = ""
        XCTAssertEqual(movieListVC.validSearch(searchText), false)
        
        //only spaces
        searchText = "    "
        XCTAssertEqual(movieListVC.validSearch(searchText), false)
    }
}
