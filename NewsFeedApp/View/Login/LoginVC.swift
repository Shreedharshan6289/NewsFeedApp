//
//  LoginVC.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import UIKit

class LoginVC: UIViewController {
    
    let viewModel = LoginViewModel()
    
    let logoImgView = UIImageView()
    
    let segmentedControl = UISegmentedControl(items: ["Sign-In".uppercased(),"Sign-up".uppercased()])
    
    let loginView = UIView()
    
    let userNameTxtfield = UITextField()
    let stackView = UIStackView()
    
    let passwordView = UIView()
    let passwordTxtfield = UITextField()
    let passwordToggle = UIButton()
    
    let confirmPasswordTextfield = UITextField()
    let loginButton = UIButton()
    
    var layoutDict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBindings()
        
        #if DEBUG
        setupTesting()
        setAccessibilityIdentifier()
        #endif
        
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .bgColor
        
        logoImgView.image = UIImage(named: "app_logo")
        logoImgView.contentMode = .scaleAspectFit
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["logoImgView"] = logoImgView
        self.view.addSubview(logoImgView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["loginView"] = loginView
        self.view.addSubview(loginView)
        
        self.stackView.axis = .vertical
        self.stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["stackView"] = stackView
        loginView.addSubview(stackView)
        
        segmentedControl.selectedSegmentTintColor = .themeColor
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.setTitleColor(.txtColor, state: .selected)
        segmentedControl.setTitleColor(.hexToColor("606060"), state: .normal)
        segmentedControl.setTitleFont(UIFont.appBoldFont(ofSize: 16), state: .selected)
        segmentedControl.setTitleFont(UIFont.appMediumFont(ofSize: 16), state: .normal)
        segmentedControl.layer.cornerRadius = 8
        segmentedControl.clipsToBounds = true
        segmentedControl.backgroundColor = .secondaryColor
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["segmentedControl"] = segmentedControl
        stackView.addArrangedSubview(segmentedControl)
        
        userNameTxtfield.backgroundColor = .secondaryColor
        userNameTxtfield.textColor = .darkText
        userNameTxtfield.font = UIFont.appBoldFont(ofSize: 16)
        userNameTxtfield.padding(15)
        userNameTxtfield.delegate = self
        userNameTxtfield.layer.cornerRadius = 8
        userNameTxtfield.placeholder = "User Name"
        userNameTxtfield.textAlignment = .left
        userNameTxtfield.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["userNameTxtfield"] = userNameTxtfield
        stackView.addArrangedSubview(userNameTxtfield)
        
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["passwordView"] = passwordView
        stackView.addArrangedSubview(passwordView)
        
        passwordTxtfield.isSecureTextEntry = true
        passwordTxtfield.backgroundColor = .secondaryColor
        passwordTxtfield.textColor = .darkText
        passwordTxtfield.font = UIFont.appBoldFont(ofSize: 16)
        passwordTxtfield.padding(15)
        passwordTxtfield.delegate = self
        passwordTxtfield.layer.cornerRadius = 8
        passwordTxtfield.layer.borderColor = UIColor.secondaryColor.cgColor
        passwordTxtfield.layer.borderWidth = 1
        passwordTxtfield.placeholder = "Password"
        passwordTxtfield.textAlignment = .left
        passwordTxtfield.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["passwordTxtfield"] = passwordTxtfield
        passwordView.addSubview(passwordTxtfield)
        
        passwordToggle.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        passwordToggle.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        passwordToggle.addTarget(self, action: #selector(passwordToggleAction(_ :)), for: .touchUpInside)
        passwordToggle.setImageTintColor(.lightGray)
        passwordToggle.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["passwordToggle"] = passwordToggle
        passwordView.addSubview(passwordToggle)
        
        confirmPasswordTextfield.isHidden = true
        confirmPasswordTextfield.isSecureTextEntry = true
        confirmPasswordTextfield.backgroundColor = .secondaryColor
        confirmPasswordTextfield.textColor = .darkText
        confirmPasswordTextfield.font = UIFont.appBoldFont(ofSize: 16)
        confirmPasswordTextfield.padding(15)
        confirmPasswordTextfield.delegate = self
        confirmPasswordTextfield.layer.cornerRadius = 8
        confirmPasswordTextfield.layer.borderColor = UIColor.secondaryColor.cgColor
        confirmPasswordTextfield.layer.borderWidth = 1
        confirmPasswordTextfield.placeholder = "Confrim Password"
        confirmPasswordTextfield.textAlignment = .left
        confirmPasswordTextfield.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["confirmPasswordTextfield"] = confirmPasswordTextfield
        stackView.addArrangedSubview(confirmPasswordTextfield)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginBtnAction(_ :)), for: .touchUpInside)
        loginButton.titleLabel?.font = UIFont.appSemiBold(ofSize: 18)
        loginButton.setTitleColor(.txtColor, for: .normal)
        loginButton.backgroundColor = .themeColor
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["loginButton"] = loginButton
        stackView.addArrangedSubview(loginButton)
        
        
    }
    
    func setupConstraints() {
        
        logoImgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[logoImgView(200)]-40-[loginView]", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[logoImgView]-20-|", options: [], metrics: nil, views: layoutDict))
        
        self.loginView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[stackView]-20-|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        
        self.loginView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[stackView]-10-|", options: [], metrics: nil, views: layoutDict))
        
        passwordView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[passwordTxtfield]|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        passwordView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[passwordTxtfield]|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        
        passwordToggle.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor).isActive = true
        passwordToggle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        passwordToggle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordToggle.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -15).isActive = true
        
        [segmentedControl,userNameTxtfield,passwordView,confirmPasswordTextfield,loginButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
        }
    }
    
    func setupBindings() {
        viewModel.updateUI = { [weak self] in
            guard let self = self else { return }
            confirmPasswordTextfield.isHidden = !viewModel.isSignUpMode
            loginButton.setTitle(viewModel.loginButtonTitle, for: .normal)
        }
        
        viewModel.showError = { [weak self] message in
            if !(self?.viewModel.username == "") && !(self?.viewModel.password == "") && !(self?.viewModel.confirmPassword == "") && (message == "Successfully registered. Move to login page and use the credentials to login.") {
                self?.clearFields()
            }
            self?.showAlert("", message: message)
        }
        
        viewModel.navigateToHome = { [weak self] in
            let vc = FeedsListVC()
            self?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
}

// MARK: UIButton Actions

extension LoginVC {
    
    @objc func loginBtnAction(_ sender: UIButton) {
            self.view.endEditing(true)
            viewModel.username = userNameTxtfield.text ?? ""
            viewModel.password = passwordTxtfield.text ?? ""
            viewModel.confirmPassword = confirmPasswordTextfield.text ?? ""
            viewModel.handleLogin()
        }
    
    @objc func passwordToggleAction(_ sender: UIButton) {
            sender.isSelected.toggle()
            passwordTxtfield.isSecureTextEntry.toggle()
        }
    
    @objc func segmentAction(_ sender: UISegmentedControl) {
            self.view.endEditing(true)
            clearFields()
            passwordTxtfield.isSecureTextEntry = true
            passwordToggle.isSelected = false
            viewModel.isSignUpMode = sender.selectedSegmentIndex == 1
        }
}

// MARK: Other functions

extension LoginVC {
    
    func clearFields() {
        self.userNameTxtfield.text = ""
        self.passwordTxtfield.text = ""
        self.confirmPasswordTextfield.text = ""
    }
    
    func setupTesting() {
        UserDataManager.shared.saveUserData(username: "testuser", password: "password123")
    }
    
    func setAccessibilityIdentifier() {
        logoImgView.accessibilityIdentifier = "logoImgView"
        userNameTxtfield.accessibilityIdentifier = "userNameTxtfield"
        passwordTxtfield.accessibilityIdentifier = "passwordTxtfield"
        loginButton.accessibilityIdentifier = "loginButton"
        confirmPasswordTextfield.accessibilityIdentifier = "confirmPasswordTextfield"
        passwordToggle.accessibilityIdentifier = "passwordToggle"
    }
    
}

// MARK: TextField Delegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moveToNextField(textField)
        return true
    }
    
    func moveToNextField(_ textField: UITextField) {
        if segmentedControl.selectedSegmentIndex == 0 {
            if textField == userNameTxtfield {
                self.passwordTxtfield.becomeFirstResponder()
            } else if textField == passwordTxtfield {
                self.passwordTxtfield.resignFirstResponder()
            }
        } else {
            if textField == userNameTxtfield {
                self.passwordTxtfield.becomeFirstResponder()
            } else if textField == passwordTxtfield {
                self.confirmPasswordTextfield.becomeFirstResponder()
            } else if textField == confirmPasswordTextfield {
                self.confirmPasswordTextfield.resignFirstResponder()
            }
        }
    }
}
