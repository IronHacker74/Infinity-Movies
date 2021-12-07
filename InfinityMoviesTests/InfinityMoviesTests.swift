//
//  InfinityMoviesTests.swift
//  InfinityMoviesTests
//
//  Created by Andrew Masters on 12/3/21.
//

import XCTest
@testable import InfinityMovies

class InfinityMoviesTests: XCTestCase {

    var dataManager = DataManager()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension InfinityMoviesTests {
    func testDataManagerDownloadSingleMovie() throws {
        //Invalid ID entered
        var downloadedObject: SingleMovieData!
        dataManager.downloadSingleMovieData("-1", completion: {data in
            downloadedObject = data
            XCTAssertEqual(downloadedObject.description, "'no description found'")
        })
        
        //Test for 'Teen Titans Go! To the Movies' w/ tagline: 'The superhero movie to end all superhero movies. Hopefully.'
        
        //Valid ID
        dataManager.downloadSingleMovieData("474395", completion: {data in
            downloadedObject = data
            XCTAssertEqual(downloadedObject.tagline, "The superhero movie to end all superhero movies. Hopefully.")
        })
        
    }
    
    func testDataManagerDownloadMoviesSearched() throws {
        //Test Empty
        var movieArray = [MovieTableData]()
        dataManager.downloadSearchedMovies(" 128", with: 1, completion: { data in
            movieArray = data
        })
        
        XCTAssertEqual(movieArray.count, 0)
        

        
    }
}
