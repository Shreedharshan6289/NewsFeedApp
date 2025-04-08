//
//  UserDataManager.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import Foundation


class UserDataManager {
    
    static let shared = UserDataManager()
    
    let userDefaults = UserDefaults.standard
    let userKey = "User"
    let loggedInUser = "loggedIn"
    
    func saveUserData(username: String, password: String) {
        var userData = userDefaults.dictionary(forKey: userKey) as? [String: String] ?? [:]
        userData[username] = password
        userDefaults.set(userData, forKey: userKey)
    }
    
    func validateUserData(username: String, password: String) -> Bool {
        guard let userData = userDefaults.dictionary(forKey: userKey) as? [String: String] else {
            return false
        }
        if userData[username] == password {
            userDefaults.set(username, forKey: loggedInUser) // Store logged-in user
            return true
        }
        return false
    }
    
    func isUserLoggedIn() -> Bool {
        return userDefaults.string(forKey: loggedInUser) != nil
    }
    
    func logout() {
        userDefaults.removeObject(forKey: loggedInUser)
    }
    
}
