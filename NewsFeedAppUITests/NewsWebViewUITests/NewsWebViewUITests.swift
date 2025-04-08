//
//  NewsWebViewUITests.swift
//  NewsFeedAppUITests
//
//  Created by Shreedharshan on 15/02/25.
//
import XCTest

class E_NewsWebViewUITests: A_NewsFeedAppUITest {
    
    override func setUp() {
        super.setUp()
        loginIfNeeded()
        
        let firstCell = app.tables["newsTableView"].cells.element(boundBy: 0)
        firstCell.tap()
        
        let webButton = app.buttons["newsDetailWebButton"]
        webButton.tap()
    }
    
    func test_WebViewLoadsProperly() {
        let webView = app.webViews.firstMatch
        XCTAssertTrue(webView.waitForExistence(timeout: 5), "WebView did not load")
    }
    
    func test_BackButtonExistsAndWorks() {
        
        let backButton = app.buttons["newsWebViewBackButton"]
        
        XCTAssertTrue(backButton.exists, "Back button should exist")
        backButton.tap()
        XCTAssertFalse(app.buttons["newsWebViewBackButton"].exists, "NewsWebView should be dismissed")
    }
}

extension C_FeedsListVCTests {
    func test_Logout() {
        let logoutButton = app.buttons["logoutButton"]
        logoutButton.tap()
        
        let logoutAlert = app.alerts.element
        logoutAlert.buttons["Yes"].tap()
        
        let logoImageView = app.images["logoImgView"]
        XCTAssertTrue(logoImageView.waitForExistence(timeout: 3), "Login screen should appear after logout")
    }
}

