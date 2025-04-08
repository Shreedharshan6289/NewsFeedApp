//
//  FeedsListViewModelTests.swift
//  NewsFeedAppTests
//
//  Created by Shreedharshan on 15/02/25.
//

import XCTest
@testable import NewsFeedApp

class FeedsListViewModelTests: XCTestCase {
    
    var viewModel: FeedsListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = FeedsListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_FetchNews_Success() {
        let expectation = self.expectation(description: "News fetched successfully")
        
        APIManager.shared.isMockingEnabled = true
        
        APIManager.shared.mockResponse = [
            "status": "ok",
            "articles": [
                ["title": "Test News", "description": "This is a test news", "urlToImage": "https://test.com/image.jpg"]
            ]
        ]
        
        viewModel.reloadData = {
            XCTAssertFalse(self.viewModel.articles.isEmpty, "Articles should not be empty after successful fetch")
            expectation.fulfill()
        }
        
        viewModel.fetchNews()
        
        waitForExpectations(timeout: 2.0)
    }
    
    func test_FetchNews_Failure() {
        let expectation = self.expectation(description: "Fetch news failed")
        
        viewModel.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Failed to get news")
            expectation.fulfill()
        }
        
        APIManager.shared.isMockingEnabled = true
        APIManager.shared.mockResponse = [
            "status": "error",
            "message": "Failed to get news"
        ]
        
        viewModel.fetchNews()
        
        waitForExpectations(timeout: 2.0)
    }
    
    func test_FetchNews_InvalidJSON() {
        let expectation = self.expectation(description: "Invalid JSON structure")
        
        APIManager.shared.isMockingEnabled = true
        
        viewModel.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Invalid JSON structure. Please try again later.")
            expectation.fulfill()
        }
        
        APIManager.shared.mockResponse = ["status": "ok"]
        
        viewModel.fetchNews()
        
        waitForExpectations(timeout: 2.0)
    }
    
}

