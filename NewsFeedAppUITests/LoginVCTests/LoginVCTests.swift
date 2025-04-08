//
//  LoginVCTests.swift
//  NewsFeedAppUITests
//
//  Created by Shreedharshan on 15/02/25.
//
import XCTest


class B_LoginVCTests: A_NewsFeedAppUITest {
    
    func test1_UIElementsExist() {
        if app.buttons["logoutButton"].exists {
            logoutIfNeeded()
        }
        
        XCTAssertTrue(app.textFields["userNameTxtfield"].exists, "Username text field is missing")
        XCTAssertTrue(app.secureTextFields["passwordTxtfield"].exists, "Password text field is missing")
        XCTAssertTrue(app.buttons["loginButton"].exists, "Login button is missing")
    }
    
    func test2_SwitchToSignUpMode() {
        if app.buttons["logoutButton"].exists {
            logoutIfNeeded()
        }
        let segmentedControl = app.segmentedControls.firstMatch
        segmentedControl.buttons["SIGN-UP"].tap()
        
        XCTAssertTrue(app.secureTextFields["confirmPasswordTextfield"].exists, "Confirm Password field should be visible in Sign-Up mode")
    }
    
    func test3_LoginWithEmptyCredentials_ShouldShowError() {
        if app.buttons["logoutButton"].exists {
            logoutIfNeeded()
        }
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists, "Error alert should be displayed")
    }
    
    func test4_PasswordToggleButton_ShouldToggleVisibility() {
        if app.buttons["logoutButton"].exists {
            logoutIfNeeded()
        }
        let passwordToggle = app.buttons["passwordToggle"]
        let passwordField = app.secureTextFields["passwordTxtfield"]
        
        // Initially, password field should be a secure text field
        XCTAssertTrue(passwordField.exists, "Password field should exist")
        
        // Tap to toggle visibility
        passwordToggle.tap()
        
        // Now, password should be a regular text field (not secure)
        XCTAssertFalse(app.secureTextFields["passwordTxtfield"].exists, "Password field should be visible")
        
        // Tap again to toggle back to secure entry
        passwordToggle.tap()
        
        // Now, password should be secure again
        XCTAssertTrue(app.secureTextFields["passwordTxtfield"].exists, "Password field should be hidden")
    }
    
    func test5_LoginSuccessful_NavigatesToFeedsList() {
        if app.textFields["userNameTxtfield"].exists {
            loginIfNeeded()
        }
        XCTAssertTrue(app.tables["newsTableView"].exists, "Login should navigate to Feeds List")
    }
}
