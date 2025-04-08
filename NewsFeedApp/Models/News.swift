//
//  News.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 14/02/25.
//

import Foundation

struct NewsArticle: Equatable {
    var title: String?
    var author: String?
    var urlToImage: String?
    var url: String?
    var content: String?
    var date:String?
    
    init(_ dict: [String:Any]) {
        
        if let title = dict["title"] as? String {
            self.title = title
        }
        
        if let author = dict["author"] as? String {
            self.author = author
        }
        
        if let urlToImage = dict["urlToImage"] as? String {
            self.urlToImage = urlToImage
        }
        
        if let url = dict["url"] as? String {
            self.url = url
        }
        
        if let date = dict["publishedAt"] as? String {
            self.date = date.formatDate()
        }
        
        if let content = dict["content"] as? String {
            let rawContent = content == "" ? (dict["description"] as? String ?? "Content not available") : content
            
            let cleanedContent = rawContent.replacingOccurrences(of: "\\[\\+\\d+ chars\\]", with: "", options: .regularExpression)
            
            self.content = cleanedContent.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
