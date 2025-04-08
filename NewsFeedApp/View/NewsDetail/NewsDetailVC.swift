//
//  NewsDetailVC.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    let viewModel: NewsDetailViewModel
    
    let titleView = UIView()
    let backButton = UIButton()
    let shareButton = UIButton()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let titleLbl = UILabel()
    let authorLbl = UILabel()
    let newsImageView = UIImageView()
    let contentLabel = UILabel()
    let readMoreButton = UIButton(type: .system)
    let webButton = UIButton(type: .system)
    
    var layoutDict = [String:Any]()
    
    init(viewModel: NewsDetailViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupBindings()
        viewModel.loadArticleData()
        
        #if DEBUG
        setAccessibilityIdentifier()
        #endif

        
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .bgColor
        
        layoutDict["titleView"] = titleView
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleView)
        
        backButton.setImage(UIImage(named: "ic_back"), for: .normal)
        backButton.setImageTintColor(.secondaryColor)
        backButton.addTarget(self, action: #selector(backBtnAction(_ :)), for: .touchUpInside)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["backButton"] = backButton
        titleView.addSubview(backButton)
        
        shareButton.setImage(UIImage(named: "ic_share"), for: .normal)
        shareButton.setImageTintColor(.secondaryColor)
        shareButton.addTarget(self, action: #selector(shareBtnAction(_ :)), for: .touchUpInside)
        shareButton.imageView?.contentMode = .scaleToFill
        shareButton.backgroundColor = .themeColor
        shareButton.layer.cornerRadius = 23
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["shareButton"] = shareButton
        titleView.addSubview(shareButton)
        
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["scrollView"] = scrollView
        self.view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["contentView"] = contentView
        scrollView.addSubview(contentView)
        
        newsImageView.layer.cornerRadius = 10
        newsImageView.isUserInteractionEnabled = true
        newsImageView.contentMode = .scaleAspectFit
        newsImageView.clipsToBounds = true
        newsImageView.tintColor = .secondaryColor
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        newsImageView.addGestureRecognizer(pinchGesture)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLbl.font = .appBoldTitleFont(ofSize: 22)
        titleLbl.numberOfLines = 0
        titleLbl.textColor = .txtColor
        titleLbl.textAlignment = .left
        
        authorLbl.font = .appBoldTitleFont(ofSize: 16)
        authorLbl.numberOfLines = 0
        authorLbl.textColor = .txtColor.withAlphaComponent(0.8)
        authorLbl.textAlignment = .left
        layoutDict["authorLbl"] = authorLbl
        
        contentLabel.font = .appBoldTitleFont(ofSize: 16)
        contentLabel.numberOfLines = 3
        contentLabel.textColor = .txtColor.withAlphaComponent(0.8)
        contentLabel.textAlignment = .left
        contentLabel.lineBreakMode = .byWordWrapping
        
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.addTarget(self, action: #selector(toggleContentExpansion), for: .touchUpInside)
        
        webButton.setTitle("Read Full Article", for: .normal)
        webButton.setTitleColor(.systemBlue, for: .normal)
        webButton.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [newsImageView,titleLbl, authorLbl, contentLabel, readMoreButton, webButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        setupConstraints(stackView: stackView)
        
    }
    
    func setupConstraints(stackView: UIStackView) {
        
        titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleView]-10-[scrollView]-|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleView]|", options: [], metrics: nil, views: layoutDict))
        
        titleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[backButton(35)]-8-|", options: [], metrics: nil, views: layoutDict))
        
        titleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[backButton(35)]", options: [], metrics: nil, views: layoutDict))
        
        titleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[shareButton(46)]-15-|", options: [], metrics: nil, views: layoutDict))
        
        shareButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: layoutDict))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [], metrics: nil, views: layoutDict))
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            newsImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupBindings() {
        viewModel.onArticleDataUpdated = { [weak self] article in
            guard let self = self else { return }
            self.titleLbl.text = article.title
            self.authorLbl.text = ((article.author?.isEmpty) != nil) ? nil : "By \(article.author ?? "")"
            self.authorLbl.isHidden = ((article.author?.isEmpty) != nil)
            self.contentLabel.text = article.content
            
            if let url = URL(string: article.urlToImage ?? "") {
                self.newsImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo.fill"))
                self.newsImageView.isHidden = false
            } else {
                self.newsImageView.isHidden = true
            }
        }
    }
    
    func setAccessibilityIdentifier() {
        titleLbl.accessibilityIdentifier = "newsDetailTitleLabel"
        authorLbl.accessibilityIdentifier = "newsDetailAuthorLabel"
        newsImageView.accessibilityIdentifier = "newsDetailNewsImageView"
        contentLabel.accessibilityIdentifier = "newsDetailContentLabel"
        readMoreButton.accessibilityIdentifier = "newsDetailReadMoreButton"
        webButton.accessibilityIdentifier = "newsDetailWebButton"
        backButton.accessibilityIdentifier = "newsDetailBackButton"
    }
    
}


// MARK: Object functions
extension NewsDetailVC {
    
    @objc func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func shareBtnAction(_ sender: UIButton) {
        guard let url = viewModel.articleURL else { return }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = shareButton.frame
        }
        
        present(activityVC, animated: true)
    }
    
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        if gesture.state == .changed {
            view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1.0
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                view.transform = .identity
            })
        }
    }
    
    @objc func toggleContentExpansion() {
        viewModel.isExpanded.toggle()
        contentLabel.numberOfLines = viewModel.isExpanded ? 0 : 3
        readMoreButton.setTitle(viewModel.isExpanded ? "Show Less" : "Read More", for: .normal)
    }
    
    @objc func openWebView() {
        guard let url = viewModel.articleURL else { return }
        let webVC = NewsWebViewVC(url: url)
        navigationController?.pushViewController(webVC, animated: true)
    }
    
}
