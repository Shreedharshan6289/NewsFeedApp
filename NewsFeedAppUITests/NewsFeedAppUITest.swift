//
//  NewsFeedAppUITest.swift
//  NewsFeedAppUITests
//
//  Created by Shreedharshan on 16/02/25.
//

import XCTest

class A_NewsFeedAppUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    
    override func tearDown() {
        app.terminate() // (Optional) Ensure app is properly closed
        app = nil // Release memory
        super.tearDown()
    }
    
    func loginIfNeeded() {
        let usernameField = app.textFields["userNameTxtfield"]
        let passwordField = app.secureTextFields["passwordTxtfield"]
        let loginButton = app.buttons["loginButton"]
        
        if usernameField.exists && passwordField.exists {
            usernameField.tap()
            usernameField.typeText("testuser")
            
            passwordField.tap()
            passwordField.typeText("password123")
            
            loginButton.tap()
            
            XCTAssertTrue(app.tables["newsTableView"].waitForExistence(timeout: 5), "Login failed")
        }
    }
    
    func logoutIfNeeded() {
        let logoutButton = app.buttons["logoutButton"]
        logoutButton.tap()
        
        let logoutAlert = app.alerts.element
        logoutAlert.buttons["Yes"].tap()
        
        let logoImageView = app.images["logoImgView"]
        XCTAssertTrue(logoImageView.waitForExistence(timeout: 3), "Login screen should appear after logout")
    }
}
