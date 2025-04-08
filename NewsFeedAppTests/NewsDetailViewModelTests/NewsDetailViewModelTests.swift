//
//  File.swift
//  NewsFeedAppTests
//
//  Created by Shreedharshan on 15/02/25.
//

import XCTest
@testable import NewsFeedApp

class NewsDetailViewModelTests: XCTestCase {
    
    func test_InitViewModel_ShouldHaveArticle() {
        let dict: [String: Any] = [
            "title": "Test Title",
            "author": "Test Author",
            "content": "Test Content",
            "url": "https://newsapi.org/v2/top-headlines",
            "urlToImage": "https://media.d3.nhle.com/image/private/t_ratio16_9-size50/prd/a8un6zwoz4hbbbziwjod.jpg"
        ]
        let article = NewsArticle(dict)
        let viewModel = NewsDetailViewModel(article: article)
        
        XCTAssertNotNil(viewModel.article)
        XCTAssertEqual(viewModel.article?.title, "Test Title")
    }
    
    func test_LoadArticleData_ShouldTriggerCallback() {
        let dict: [String: Any] = [
            "title": "Test Title",
            "author": "Test Author",
            "content": "Test Content",
            "url": "https://newsapi.org/v2/top-headlines",
            "urlToImage": "https://media.d3.nhle.com/image/private/t_ratio16_9-size50/prd/a8un6zwoz4hbbbziwjod.jpg"
        ]
        let article = NewsArticle(dict)
        let viewModel = NewsDetailViewModel(article: article)
        
        let expectation = self.expectation(description: "Article Data Updated")
        
        viewModel.onArticleDataUpdated = { updatedArticle in
            XCTAssertEqual(updatedArticle.title, "Test Title")
            expectation.fulfill()
        }
        
        viewModel.loadArticleData()
        waitForExpectations(timeout: 1.0)
    }
    
    func test_ToggleContentExpansion_ShouldChangeState() {
        let dict: [String: Any] = [
            "title": "Test Title",
            "author": "Test Author",
            "content": "Test Content",
            "url": "https://newsapi.org/v2/top-headlines",
            "urlToImage": "https://media.d3.nhle.com/image/private/t_ratio16_9-size50/prd/a8un6zwoz4hbbbziwjod.jpg"
        ]
        let article = NewsArticle(dict)
        let viewModel = NewsDetailViewModel(article: article)
        
        XCTAssertFalse(viewModel.isExpanded)
        viewModel.isExpanded.toggle()
        XCTAssertTrue(viewModel.isExpanded)
    }
    
    func test_ArticleURL_ShouldReturnValidURL() {
        let dict: [String: Any] = [
            "title": "Test Title",
            "author": "Test Author",
            "content": "Test Content",
            "url": "https://newsapi.org/v2/top-headlines",
            "urlToImage": "https://media.d3.nhle.com/image/private/t_ratio16_9-size50/prd/a8un6zwoz4hbbbziwjod.jpg"
        ]
        let article = NewsArticle(dict)
        let viewModel = NewsDetailViewModel(article: article)
        
        XCTAssertNotNil(viewModel.articleURL)
        XCTAssertEqual(viewModel.articleURL?.absoluteString, "https://newsapi.org/v2/top-headlines")
    }
    
    func test_ArticleURL_ShouldReturnNilForInvalidURL() {
        let dict: [String: Any] = [
            "title": "Test Title",
            "author": "Test Author",
            "content": "Test Content",
            "url": "",  // Invalid URL case
            "urlToImage": "https://media.d3.nhle.com/image/private/t_ratio16_9-size50/prd/a8un6zwoz4hbbbziwjod.jpg"
        ]
        let article = NewsArticle(dict)
        let viewModel = NewsDetailViewModel(article: article)
        
        XCTAssertNil(viewModel.articleURL)
    }
}
