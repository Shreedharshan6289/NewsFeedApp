//
//  NewsDetailViewModel.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import Foundation


class NewsDetailViewModel {
    
    var article: NewsArticle?
    var isExpanded = false
    var onArticleDataUpdated: ((NewsArticle) -> Void)?
    
    var articleURL: URL? {
        guard let urlString = article?.url else { return nil }
        return URL(string: urlString)
    }
    
    init(article: NewsArticle) {
        self.article = article
    }
    
    func loadArticleData() {
        guard let article = article else { return }
        onArticleDataUpdated?(article)
    }
    
    
    
}
