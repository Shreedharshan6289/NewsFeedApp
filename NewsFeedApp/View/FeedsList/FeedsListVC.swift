//
//  NewsVC.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import UIKit
import SDWebImage

class FeedsListVC: UIViewController {
    
    let viewModel = FeedsListViewModel()
    
    let titleView = UIView()
    let titleLbl = UILabel()
    let logoutButton = UIButton()
    
    let refreshControl = UIRefreshControl()
    let tableView = UITableView()
    
    let errorView = UIView()
    let errorImgView = UIImageView()
    let errorLbl = UILabel()
    let errorDiscriptionLbl = UILabel()
    let tryAgainButton = UIButton()
    
    var layoutDict = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupBindings()
        viewModel.fetchNews()
        
        #if DEBUG
        setAccessibilityIdentifier()
        #endif
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBindings()
        viewModel.fetchNews()
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .bgColor
        
        // Title View
        
        layoutDict["titleView"] = titleView
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleView)
        
        titleLbl.text = "Today's Updates"
        titleLbl.font = .appBoldTitleFont(ofSize: 30)
        titleLbl.textColor = .txtColor
        titleLbl.textAlignment = .left
        layoutDict["titleLbl"] = titleLbl
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(titleLbl)
        
        logoutButton.setImage(UIImage(named: "ic_logout"), for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutBtnAction(_ :)), for: .touchUpInside)
        logoutButton.imageView?.contentMode = .scaleAspectFill
        logoutButton.setImageTintColor(.secondaryColor)
        logoutButton.backgroundColor = .themeColor
        logoutButton.layer.cornerRadius = 23
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["logoutButton"] = logoutButton
        titleView.addSubview(logoutButton)
        
        // News Tableview
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor
        tableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["tableView"] = tableView
        view.addSubview(tableView)
        
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing News...", attributes: [
            .foregroundColor: UIColor.secondaryColor,
            .font: UIFont.appSemiBold(ofSize: 15)
        ])
        tableView.refreshControl = refreshControl
        
        // Error view
        
        errorView.isHidden = true
        errorView.backgroundColor = .bgColor
        errorView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["errorView"] = errorView
        view.addSubview(errorView)
        
        errorImgView.image = UIImage(named: "ic_alert")
        errorImgView.contentMode = .scaleAspectFill
        errorImgView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["errorImgView"] = errorImgView
        errorView.addSubview(errorImgView)
        
        errorLbl.text = "Error"
        errorLbl.font = .appBoldTitleFont(ofSize: 22)
        errorLbl.textColor = .txtColor
        errorLbl.numberOfLines = 0
        errorLbl.textAlignment = .center
        layoutDict["errorLbl"] = errorLbl
        errorLbl.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(errorLbl)
        
        errorDiscriptionLbl.font = .appBoldTitleFont(ofSize: 19)
        errorDiscriptionLbl.textColor = .txtColor
        errorDiscriptionLbl.numberOfLines = 0
        errorDiscriptionLbl.textAlignment = .center
        layoutDict["errorDiscriptionLbl"] = errorDiscriptionLbl
        errorDiscriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(errorDiscriptionLbl)
        
        tryAgainButton.setTitle("Try Again", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainBtnAction(_ :)), for: .touchUpInside)
        tryAgainButton.titleLabel?.font = UIFont.appSemiBold(ofSize: 18)
        tryAgainButton.setTitleColor(.txtColor, for: .normal)
        tryAgainButton.backgroundColor = .themeColor
        tryAgainButton.layer.cornerRadius = 8
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["tryAgainButton"] = tryAgainButton
        errorView.addSubview(tryAgainButton)
        
    }
    
    func setupConstraints() {
        
        titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleView]-5-[tableView]-15-|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleView]|", options: [], metrics: nil, views: layoutDict))
        
        titleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[titleLbl(40)]-8-|", options: [], metrics: nil, views: layoutDict))
        
        titleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[titleLbl]-15-[logoutButton(46)]-15-|", options: [], metrics: nil, views: layoutDict))
        logoutButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            errorImgView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            errorImgView.centerYAnchor.constraint(equalTo: errorView.centerYAnchor,constant: -30),
            errorImgView.heightAnchor.constraint(equalToConstant: 200),
            errorImgView.widthAnchor.constraint(equalToConstant: 200),
            
            errorLbl.topAnchor.constraint(equalTo: errorImgView.bottomAnchor, constant: 15),
            errorLbl.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 15),
            errorLbl.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -15),
            
            errorDiscriptionLbl.topAnchor.constraint(equalTo: errorLbl.bottomAnchor, constant: 8),
            errorDiscriptionLbl.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 15),
            errorDiscriptionLbl.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -15),
            
            tryAgainButton.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 25),
            tryAgainButton.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -25),
            tryAgainButton.bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: -25),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupBindings() {
        GIFLoaderView.shared.start()
        
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                GIFLoaderView.shared.stop()
                self?.updateUIForSuccess()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                GIFLoaderView.shared.stop()
                self?.updateUIForError(errorMessage)
            }
        }
    }
}

// MARK: OBJECT FUNCTIONS
extension FeedsListVC {
    
    @objc func logoutBtnAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Are you sure you want to logout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in self.logout() })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func refreshNews() {
        if APIManager.isConnectedToNetwork() {
            viewModel.fetchNews()
        } else {
            showAlert("Network Error", message: "No Internet Connection")
            updateUIForError("No Internet Connection")
        }
    }
    
    @objc func tryAgainBtnAction(_ sender: UIButton) {
        GIFLoaderView.shared.start()
        viewModel.fetchNews()
    }
    
}

// MARK: OTHER FUNCTIONS
extension FeedsListVC {
    
    func setAccessibilityIdentifier() {
        titleLbl.accessibilityIdentifier = "titleLbl"
        tableView.accessibilityIdentifier = "newsTableView"
        logoutButton.accessibilityIdentifier = "logoutButton"
        tryAgainButton.accessibilityIdentifier = "tryAgainButton"
        refreshControl.accessibilityIdentifier = "refreshControl"
    }
    
    func updateUIForSuccess() {
        errorView.isHidden = true
        refreshControl.endRefreshing()
        tableView.reloadData()
        
        if viewModel.articles.isEmpty {
            errorView.isHidden = false
            errorDiscriptionLbl.text = "No new news updates"
        }
    }
    
    func updateUIForError(_ errorMessage: String) {
        refreshControl.endRefreshing()
        
        if !APIManager.isConnectedToNetwork() {
            showAlert("Network Error", message: "No Internet Connection")
            errorView.isHidden = false
            errorLbl.text = "Network Error"
            errorDiscriptionLbl.text = "No Internet Connection"
        } else {
            showAlert("Error", message: errorMessage.localizedCapitalized)
            errorView.isHidden = false
            errorDiscriptionLbl.text = errorMessage.localizedCapitalized
        }
    }
    
    func logout() {
        UserDataManager.shared.logout()
        UserDefaults.standard.synchronize()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.showLoginScreen()
        }
    }
    
}

// MARK: UITableView Delegate & DataSource
extension FeedsListVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.identifier, for: indexPath) as? NewsFeedCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]
        let detailViewModel = NewsDetailViewModel(article: article)
        let detailVC = NewsDetailVC(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
