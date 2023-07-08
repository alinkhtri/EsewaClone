//
//  LoginViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 25/06/2023.
//

import UIKit
import JDStatusBarNotification

class LoginViewController: UIViewController {
    
    
    private var viewModel = LoginViewModel()
    
    // UI elements
    let headingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LOGO")
        return imageView
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Sign in to continue"
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Welcome"
        return label
    }()
    
    
    let mobileLoginView: UIView = {
        let view = UIView()
        // Customize mobile login view properties
        return view
    }()
    
    
    private let mobileNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mobile Number"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let mobileNumberTextFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "Username"
        return label
    }()
    
    
    private let passwordTextFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "Password/MPIN"
        return label
    }()
    
    private let passwordToggleBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot MPIN?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(UIColor(named: "EAccent"), for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("REGISTER FOR FREE", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor(named: "EAccent"), for: .normal)
        return button
    }()
    
    let passwordStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 8
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .secondarySystemBackground
        
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.observeEvent()
        self.setupNavBar()
        self.setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupNavBar() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeView))
        backButton.tintColor = .label
        
        navigationItem.rightBarButtonItem = backButton
    }
    
    private func setupUI() {
        let mobileNoTextField = CustomTextField()
        mobileNoTextField.keyboardType = .numberPad
        mobileNoTextField.placeholder = "Username"
        
        let passwordTextField = CustomTextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
        let loginButton = PrimaryButton(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.onPress = {
            
            let username = mobileNoTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            
            if username.isEmpty || password.isEmpty {
                self.showToastAlert(text: "Username or Password is required")
                return
            }
            
            let loginRequest = LoginRequest(username: username, password: password)
            self.viewModel.loginUser(parameter: loginRequest)
            
        }
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(mobileNumberTextFieldLabel)
        stackView.addArrangedSubview(mobileNoTextField)
        stackView.addArrangedSubview(passwordTextFieldLabel)
        stackView.addArrangedSubview(passwordTextField)
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
        
        // Configure the view controller's UI
        
        view.addSubview(headingImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(signInLabel)
        view.addSubview(stackView)
        view.addSubview(forgotButton)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        // Add constraints for the UI elements
        
        // Heading image view constraints
        headingImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            headingImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            headingImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            welcomeLabel.topAnchor.constraint(equalTo: headingImageView.bottomAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            signInLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
            signInLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mobileNoTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            
            forgotButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            forgotButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc func loginButtonTapped() {
        
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        
        // Present the alert
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }

    
    @objc func forgotButtonTapped() {
        print("Forgot")
    }
    
    @objc func registerButtonTapped() {
        let registerVC = RegisterViewController()
        let navController = UINavigationController(rootViewController: registerVC)
        navController.modalPresentationStyle = .overCurrentContext
        present(navController, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController {
    
    // Function to show the toast alert
    func showToastAlert(text: String? = nil) {
        // set a named custom style
        NotificationPresenter.shared().addStyle(styleName: "toast") { style in
            
            style.backgroundStyle.backgroundType = StatusBarNotificationBackgroundType.fullWidth
            
            style.backgroundStyle.backgroundColor = .red
            style.textStyle.textColor = .white
            style.textStyle.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            
            return style
        }
        
        
        NotificationPresenter.shared().present(text: text ?? "Unknown error occured", dismissAfterDelay: 3, customStyle: "toast")
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("Loading...")
                break
            case .stopLoading:
                print("Stop Loading....")
                break
            case .loggedInUser(let user):
                print(user)
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self.showToastAlert(text: "Invalid Login Credentials")
                }
                print(error)
            }
        }
    }
    
    
}
