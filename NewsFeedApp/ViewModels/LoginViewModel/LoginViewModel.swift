//
//  LoginViewModel.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import Foundation

class LoginViewModel {
    
    var username = ""
    var password = ""
    var confirmPassword = ""
    
    var isSignUpMode = false {
        didSet { updateUI?() }
    }
    
    var loginButtonTitle: String {
        return isSignUpMode ? "Sign-Up" : "Login"
    }
    
    var updateUI: (() -> Void)?
    var showError: ((String) -> Void)?
    var navigateToHome: (() -> Void)?
    
    func handleLogin() {
        if isSignUpMode {
            registerUser()
        } else {
            validateUser()
        }
    }
    
    func validateUser() {
        guard !username.isEmpty, !password.isEmpty else {
            
            if username.isEmpty && password.isEmpty  {
                showError?("Username and Password cannot be empty")
            } else if username.isEmpty {
                showError?("Username cannot be empty")
            } else if password.isEmpty {
                showError?("Password cannot be empty")
            }
            
            return
        }
        
        if UserDataManager.shared.validateUserData(username: username, password: password) {
            navigateToHome?()
        } else {
            showError?("Invalid username or password.")
        }
    }
    
    func registerUser() {
        guard !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            showError?("All fields are required.")
            return
        }
        
        guard password == confirmPassword else {
            showError?("Passwords do not match.")
            return
        }
        
        guard let userData = UserDefaults.standard.dictionary(forKey: "User") as? [String: String] else {
            return
        }
        if !(userData.keys.contains(username)) {
            UserDataManager.shared.saveUserData(username: username, password: password)
            showError?("Successfully registered. Move to login page and use the credentials to login.")
        } else {
            showError?("User name already taken")
        }
        
        
    }
}
