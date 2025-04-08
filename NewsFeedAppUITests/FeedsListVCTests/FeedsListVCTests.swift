//
//  FeedsListVCTests.swift
//  NewsFeedAppUITests
//
//  Created by Shreedharshan on 15/02/25.
//

import XCTest

class C_FeedsListVCTests: A_NewsFeedAppUITest {
    
    override func setUp() {
        super.setUp()
        loginIfNeeded()
    }
    
    func test_UIElementsExistence() {
        XCTAssertTrue(app.staticTexts["titleLbl"].waitForExistence(timeout: 5), "Title label should be present")
        XCTAssertTrue(app.tables["newsTableView"].waitForExistence(timeout: 5), "News table view should be present")
        XCTAssertTrue(app.buttons["logoutButton"].waitForExistence(timeout: 5), "Logout button should be present")
    }
    
    func test_TryAgainButton_ShowsNewsOnRetry() {
        let tryAgainButton = app.buttons["tryAgainButton"]
        
        if tryAgainButton.exists {
            tryAgainButton.tap()
            let tableView = app.tables["newsTableView"]
            XCTAssertTrue(tableView.exists, "News table should be displayed after retry")
        }
    }
    
    func test_NavigationToDetailScreen() {
        let tableView = app.tables["newsTableView"]
        XCTAssertTrue(tableView.exists, "News list should be visible")
        
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First news item should exist")
        firstCell.tap()
        
        XCTAssertTrue(app.staticTexts["newsDetailTitleLabel"].exists, "News detail screen should be displayed")
    }
    
    func test_LogoutConfirmationDialog() {
        let logoutButton = app.buttons["logoutButton"]
        logoutButton.tap()
        
        let logoutAlert = app.alerts.element
        XCTAssertTrue(logoutAlert.exists, "Logout confirmation alert should appear")
        
        let yesButton = logoutAlert.buttons["Yes"]
        XCTAssertTrue(yesButton.exists, "Yes button should be present")
        
        yesButton.tap()
        let logoImageView = app.images["logoImgView"]
        XCTAssertTrue(logoImageView.waitForExistence(timeout: 3), "Login screen should appear after logout")
    }
}
