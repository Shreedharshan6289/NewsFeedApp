//
//  NewsViewModel.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import Foundation


class FeedsListViewModel {
    
    var articles: [NewsArticle] = []
    var articlesWithImages: [NewsArticle] = []
    var reloadData: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchNews() {
        let parameters: [String: String] = [
            "country": "us",
            "apiKey": APIManager.shared.apiKey
        ]
        
        APIManager.shared.get(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let response):
                if let status = response["status"] as? String, status == "ok" {
                    if let articles = response["articles"] as? [[String:Any]] {
                        self?.articles = articles.compactMap({ NewsArticle($0) })
                        if  let list = self?.articles {
                            self?.articlesWithImages = list.filter{$0.urlToImage != ""}
                        }
                        
                        self?.reloadData?()
                    } else {
                        self?.onError?("Invalid JSON structure. Please try again later.")
                    }
                } else {
                    self?.onError?("Failed to get news")
                }
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
