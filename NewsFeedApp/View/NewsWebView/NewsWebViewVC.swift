//
//  NewsWebViewVC.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 14/02/25.
//

import UIKit
import WebKit

class NewsWebViewVC: UIViewController {
    
    let viewModel: NewsWebViewModel
    
    let titleView = UIView()
    let backButton = UIButton()
    let progressBar = UIProgressView(progressViewStyle: .bar)
    var progressObservation: NSKeyValueObservation?
    let webView = WKWebView()
    
    var layoutDict = [String:Any]()
    
    init(url: URL) {
        self.viewModel = NewsWebViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBindings()
        setupObservers()
        viewModel.loadWebPage()
        
        #if DEBUG
        setAccessibilityIdentifier()
        #endif
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .bgColor
        
        layoutDict["titleView"] = titleView
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleView)
        
        backButton.setImage(UIImage(named:"ic_back"), for: .normal)
        backButton.setImageTintColor(.secondaryColor)
        backButton.addTarget(self, action: #selector(backBtnAction(_ :)), for: .touchUpInside)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["backButton"] = backButton
        titleView.addSubview(backButton)
        
        progressBar.tintColor = .systemBlue
        progressBar.trackTintColor = .gray
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["progressBar"] = progressBar
        self.view.addSubview(progressBar)
        
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["webView"] = webView
        self.view.addSubview(webView)
        
    }
    
    func setupConstraints() {
        titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleView]-5-[progressBar(4)][webView]-10-|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleView]|", options: [], metrics: nil, views: layoutDict))
        
        titleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[backButton(35)]-8-|", options: [], metrics: nil, views: layoutDict))
        
        titleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[backButton(35)]", options: [], metrics: nil, views: layoutDict))
    }
    
    func setupBindings() {
        viewModel.onError = { [weak self] errorMessage in
            self?.showAlert(title: "Error", msg: errorMessage)
        }
        
        viewModel.onLoadRequest = { [weak self] request in
            self?.webView.load(request)
        }
    }
}


// MARK: Object functions
extension NewsWebViewVC {
    
    @objc func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Other functions
extension NewsWebViewVC {
    
    func setAccessibilityIdentifier() {
        webView.accessibilityIdentifier = "webView"
        backButton.accessibilityIdentifier = "newsWebViewBackButton"
    }
    
    func setupObservers() {
        progressObservation = webView.observe(\.estimatedProgress, options: .new) { [weak self] _, change in
            guard let self = self else { return }
            if let newProgress = change.newValue {
                self.progressBar.progress = Float(newProgress)
                
                if newProgress >= 1.0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.progressBar.isHidden = true
                    }
                } else {
                    self.progressBar.isHidden = false
                }
            }
        }
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont.appBoldTitleFont(ofSize: 18)]
        let titleAttrString = NSAttributedString(string: title, attributes: titleFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        
        let messageFont = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 16)]
        let messageAttrString = NSAttributedString(string: msg, attributes: messageFont)
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: Webview Delegates
extension NewsWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.loadingFinished()
        progressBar.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        viewModel.loadingFailed(error: error)
        progressBar.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        viewModel.loadingFailed(error: error)
        progressBar.isHidden = true
    }
    
}
