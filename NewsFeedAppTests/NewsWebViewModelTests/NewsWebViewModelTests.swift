//
//  NewsWebViewModelTests.swift
//  NewsFeedAppTests
//
//  Created by Shreedharshan on 15/02/25.
//

import XCTest
@testable import NewsFeedApp

class NewsWebViewModelTests: XCTestCase {
    
    var viewModel: NewsWebViewModel!
    
    override func setUp() {
        super.setUp()
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines")
        viewModel = NewsWebViewModel(url: url!)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_LoadWebPage_ValidURL_ShouldCallOnLoadRequest() {
        let expectation = self.expectation(description: "URL request should be loaded")
        
        //        viewModel.url = URL(string: "https://newsapi.org/v2/top-headlines")
        
        viewModel.onLoadRequest = { request in
            XCTAssertEqual(request.url, self.viewModel.url)
            expectation.fulfill()
        }
        
        viewModel.loadWebPage()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_LoadWebPage_InvalidURL_ShouldTriggerError() {
        let expectation = self.expectation(description: "Should trigger an error")
        
        viewModel.url = nil
        viewModel.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Invalid url")
            expectation.fulfill()
        }
        
        viewModel.loadWebPage()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_LoadingFinished_ShouldStopLoadingIndicator() {
        let expectation = self.expectation(description: "Loading should stop")
        
        viewModel.onLoadingStateChanged = { isLoading in
            if !isLoading {
                expectation.fulfill()
            }
        }
        
        viewModel.loadingFinished()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_LoadingFailed_ShouldTriggerError() {
        let expectation = self.expectation(description: "Should show error")
        
        let testError = NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network Error"])
        
        viewModel.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Network Error")
            expectation.fulfill()
        }
        
        viewModel.loadingFailed(error: testError)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
