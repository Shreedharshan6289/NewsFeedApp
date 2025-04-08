//
//  LoginViewModelTests.swift
//  NewsFeedAppTests
//
//  Created by Shreedharshan on 15/02/25.
//

import XCTest
@testable import NewsFeedApp

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_Login_WithEmptyUsername_ShouldShowError() {
        viewModel.username = ""
        viewModel.password = "password123"
        
        let expectation = self.expectation(description: "Error message should be shown")
        
        viewModel.showError = { message in
            XCTAssertEqual(message, "Username cannot be empty")
            expectation.fulfill()
        }
        
        viewModel.handleLogin()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_Login_WithEmptyPassword_ShouldShowError() {
        viewModel.username = "testuser"
        viewModel.password = ""
        
        let expectation = self.expectation(description: "Error message should be shown")
        
        viewModel.showError = { message in
            XCTAssertEqual(message, "Password cannot be empty")
            expectation.fulfill()
        }
        
        viewModel.handleLogin()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_Login_WithEmptyUserNameANdPassword_ShouldShowError() {
        viewModel.username = ""
        viewModel.password = ""
        
        let expectation = self.expectation(description: "Error message should be shown")
        
        viewModel.showError = { message in
            XCTAssertEqual(message, "Username and Password cannot be empty")
            expectation.fulfill()
        }
        
        viewModel.handleLogin()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_SignUpMode_ConfirmPasswordRequired() {
        viewModel.isSignUpMode = true
        viewModel.username = "newuser"
        viewModel.password = "password123"
        viewModel.confirmPassword = ""
        
        let expectation = self.expectation(description: "Error message should be shown")
        
        viewModel.showError = { message in
            XCTAssertEqual(message, "All fields are required.")
            expectation.fulfill()
        }
        
        viewModel.handleLogin()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_SignUpMode_PasswordMismatch_ShouldShowError() {
        viewModel.isSignUpMode = true
        viewModel.username = "newuser"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password456"
        
        let expectation = self.expectation(description: "Error message should be shown")
        
        viewModel.showError = { message in
            XCTAssertEqual(message, "Passwords do not match.")
            expectation.fulfill()
        }
        
        viewModel.handleLogin()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_Login_WithValidCredentials_ShouldNavigateToHome() {
        viewModel.isSignUpMode = false
        viewModel.username = "testuser"
        viewModel.password = "password123"
        
        let expectation = self.expectation(description: "Navigate to Home should be called")
        
        viewModel.navigateToHome = {
            expectation.fulfill()
        }
        
        viewModel.handleLogin()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
