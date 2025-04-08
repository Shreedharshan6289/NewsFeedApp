//
//  File.swift
//  NewsFeedAppUITests
//
//  Created by Shreedharshan on 15/02/25.
//

import XCTest

class D_NewsDetailVCTests: A_NewsFeedAppUITest {
    
    override func setUp() {
        super.setUp()
        loginIfNeeded()
        
        let firstCell = app.tables["newsTableView"].cells.element(boundBy: 0)
        firstCell.tap()
    }
    
    func test_UIElementsExistence() {
        XCTAssertTrue(app.staticTexts["newsDetailTitleLabel"].waitForExistence(timeout: 5), "Title label should be present")
        XCTAssertTrue(app.images["newsDetailNewsImageView"].waitForExistence(timeout: 5), "News image view should be present")
        XCTAssertTrue(app.staticTexts["newsDetailContentLabel"].waitForExistence(timeout: 5), "Content label should be present")
        XCTAssertTrue(app.buttons["newsDetailReadMoreButton"].waitForExistence(timeout: 5), "Read More button should be present")
        XCTAssertTrue(app.buttons["newsDetailWebButton"].waitForExistence(timeout: 5), "Web button should be present")
        XCTAssertTrue(app.buttons["newsDetailBackButton"].waitForExistence(timeout: 5), "Back button should be present")
    }
    
    func test_ToggleContentExpansion_ChangesLabelLines() {
        let readMoreButton = app.buttons["newsDetailReadMoreButton"]
        
        XCTAssertTrue(readMoreButton.exists, "Read More button should exist")
        
        // Tap to expand
        readMoreButton.tap()
        XCTAssertEqual(readMoreButton.label, "Show Less")
        
        // Tap to collapse
        readMoreButton.tap()
        XCTAssertEqual(readMoreButton.label, "Read More")
    }
    
    func test_OpenWebView_PushesWebView() {
        let webButton = app.buttons["newsDetailWebButton"]
        XCTAssertTrue(webButton.waitForExistence(timeout: 5), "Web button should exist")
        
        webButton.tap()
        XCTAssertTrue(app.webViews.firstMatch.waitForExistence(timeout: 5), "WebView should be displayed")
    }
    
    func test_BackButton_PopsViewController() {
        let backButton = app.buttons["newsDetailBackButton"]
        XCTAssertTrue(backButton.exists, "Back button should exist")
        backButton.tap()
        
        // Assuming NewsDetailVC was pushed, now it should be dismissed
        XCTAssertFalse(app.staticTexts["newsDetailTitleLabel"].exists, "NewsDetailVC should be dismissed")
    }
    
    
    
}

