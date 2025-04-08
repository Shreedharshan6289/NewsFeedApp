//
//  NewsFeedCell.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 14/02/25.
//

import Foundation
import UIKit


class NewsFeedCell: UITableViewCell {
    
    static let identifier = "NewsFeedCell"
    
    let viewContent = UIView()
    let imgview = UIImageView()
    let titleLbl = UILabel()
    let authorLbl = UILabel()
    let dateLbl = UILabel()
    
    var layoutDict = [String:Any]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.backgroundColor = .bgColor
        self.selectionStyle = .none
        
        //        viewContent.backgroundColor = .secondaryColor
        viewContent.layer.cornerRadius = 10
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["viewContent"] = viewContent
        self.addSubview(viewContent)
        
        imgview.layer.cornerRadius = 10
        imgview.tintColor = .secondaryColor
        imgview.contentMode = .scaleAspectFill
        imgview.clipsToBounds = true
        imgview.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["imgview"] = imgview
        viewContent.addSubview(imgview)
        
        titleLbl.font = .appBoldTitleFont(ofSize: 16)
        titleLbl.numberOfLines = 2
        titleLbl.textColor = .txtColor
        titleLbl.textAlignment = .left
        titleLbl.lineBreakMode = .byWordWrapping
        layoutDict["titleLbl"] = titleLbl
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(titleLbl)
        
        authorLbl.font = .appBoldTitleFont(ofSize: 14)
        authorLbl.textColor = .txtColor.withAlphaComponent(0.8)
        authorLbl.textAlignment = .left
        authorLbl.lineBreakMode = .byWordWrapping
        layoutDict["authorLbl"] = authorLbl
        authorLbl.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(authorLbl)
        
        dateLbl.font = .appBoldTitleFont(ofSize: 14)
        dateLbl.textColor = .txtColor.withAlphaComponent(0.8)
        dateLbl.textAlignment = .left
        dateLbl.lineBreakMode = .byWordWrapping
        layoutDict["dateLbl"] = dateLbl
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(dateLbl)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[viewContent(120)]-15-|",options: [],metrics: nil,views: layoutDict))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[viewContent]-15-|",options: [],metrics: nil,views: layoutDict))
        
        viewContent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[imgview(100)]-10-|",options: [],metrics: nil,views: layoutDict))
        
        viewContent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgview(120)]-10-[titleLbl]-10-|",options: [],metrics: nil,views: layoutDict))
        
        viewContent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[titleLbl]",options: [],metrics: nil,views: layoutDict))
        
        authorLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor).isActive = true
        authorLbl.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor).isActive = true
        
        viewContent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[authorLbl][dateLbl]-15-|",options: [.alignAllLeading,.alignAllTrailing],metrics: nil,views: layoutDict))
        
    }
    
    func configure(with article: NewsArticle) {
        titleLbl.text = article.title
        authorLbl.text = article.author ?? "Unknown Author"
        dateLbl.text = article.date ?? ""
        
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            imgview.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo.fill"))
        } else {
            imgview.image = UIImage(systemName: "photo.fill")
        }
    }
}
