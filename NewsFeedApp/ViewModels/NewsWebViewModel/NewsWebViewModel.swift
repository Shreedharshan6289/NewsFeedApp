//
//  NewsWebViewModel.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 14/02/25.
//

import Foundation


class NewsWebViewModel {
    
    var url: URL?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onLoadRequest: ((URLRequest) -> Void)?
    
    init(url: URL) {
        self.url = url
    }
    
    func loadWebPage() {
        onLoadingStateChanged?(true)
        if let url = self.url {
            let request = URLRequest(url: url)
            onLoadRequest?(request)
        } else {
            onError?("Invalid url")
        }
        
    }
    
    func loadingFinished() {
        onLoadingStateChanged?(false)
    }
    
    func loadingFailed(error: Error) {
        onLoadingStateChanged?(false)
        onError?(error.localizedDescription)
    }
}
