//
//  RegisterViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 28/06/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Variable
    private var genderOptions: [String] = ["Male", "Female", "Other"]
    
    
    // MARK: - UI Components
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Your mobile number will be your esewa ID"
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Registration"
        return label
    }()
    
    
    let mobileLoginView: UIView = {
        let view = UIView()
        // Customize mobile login view properties
        return view
    }()
    
    
    private let mobileNumberTextFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "Mobile Number"
        return label
    }()
    
    
    private let fullNameTextFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "Full Name"
        return label
    }()
    
    private let genderTextFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "Gender"
        return label
    }()

    private let genderTextField = CustomTextField()
    
    
    private let promoCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("  Have a Promo Code?  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(UIColor(named: "EAccent"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "EAccent")?.cgColor
            button.layer.cornerRadius = 5
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
    
    private let genderPickerView = UIPickerView()
    
    
    private let checkboxButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "square"), for: .normal)
            button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            button.tintColor = UIColor(named: "EAccent")
            button.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
            return button
        }()
        
        private let termsTextView: UITextView = {
            let textView = UITextView()
            textView.isEditable = false
            textView.isScrollEnabled = false
            textView.linkTextAttributes = [
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            return textView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        self.setupNavBar()
        self.setupUI()
    }
    
    // MARK: - UI Setup
    private func setupNavBar() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(closeView))
        backButton.tintColor = UIColor(named: "EAccent")
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    private func setupUI() {
        
        setupTermsAttributedString()
        
        let mobileNoTextField = CustomTextField()
        mobileNoTextField.keyboardType = .numberPad
        mobileNoTextField.placeholder = "Mobile Number"
        
        let fullNameTextField = CustomTextField()
        fullNameTextField.placeholder = "Full Name"
        

        genderTextField.placeholder = "Gender"
        genderTextField.inputView = genderPickerView
        
        
        let registerButton = PrimaryButton(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        registerButton.setTitle("REGISTER", for: .normal)
        registerButton.onPress = {
            
            print("Button pressed")
        }
        
        
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(mobileNumberTextFieldLabel)
        stackView.addArrangedSubview(mobileNoTextField)
        stackView.addArrangedSubview(fullNameTextFieldLabel)
        stackView.addArrangedSubview(fullNameTextField)
        stackView.addArrangedSubview(genderTextFieldLabel)
        stackView.addArrangedSubview(genderTextField)
        
        let aggrementStackView = UIStackView()
        aggrementStackView.axis = .horizontal
        aggrementStackView.spacing = 10
        aggrementStackView.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        promoCodeButton.addTarget(self, action: #selector(promoCodeButtonTapped), for: .touchUpInside)
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
                termsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        aggrementStackView.addArrangedSubview(checkboxButton)
        aggrementStackView.addArrangedSubview(termsTextView)
        
        // Configure the view controller's UI
        
        view.addSubview(welcomeLabel)
        view.addSubview(signInLabel)
        view.addSubview(stackView)
        view.addSubview(promoCodeButton)
        view.addSubview(registerButton)
        view.addSubview(aggrementStackView)
        
        // Add constraints for the UI elements
        
        // Heading image view constraints
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        promoCodeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            signInLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
            signInLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mobileNoTextField.heightAnchor.constraint(equalToConstant: 50),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 50),
            genderTextField.heightAnchor.constraint(equalToConstant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 55),
            
            promoCodeButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            promoCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            aggrementStackView.topAnchor.constraint(equalTo: promoCodeButton.bottomAnchor, constant: 10),
            aggrementStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aggrementStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: aggrementStackView.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            
            
            
        ])
    }
    
    private func setupTermsAttributedString() {
            let attributedString = NSMutableAttributedString(string: "I accept the ")
            let termsLinkString = NSAttributedString(string: "Terms and Conditions", attributes: [
                .link: URL(string: "https://blog.esewa.com.np/terms-and-conditions/")!,
                .font: UIFont.systemFont(ofSize: 14)
            ])
        let andText = NSMutableAttributedString(string: " & ")
        let privacyLinkString = NSAttributedString(string: "Privacy Policy", attributes: [
            .link: URL(string: "https://blog.esewa.com.np/privacy-policy/")!,
            .font: UIFont.systemFont(ofSize: 14)
        ])
            attributedString.append(termsLinkString)
        attributedString.append(andText)
        attributedString.append(privacyLinkString)
            termsTextView.attributedText = attributedString
        termsTextView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        termsTextView.textColor = .label
        termsTextView.linkTextAttributes = [.foregroundColor : UIColor(named: "EAccent") ?? .label]
        }
    
    
    @objc func promoCodeButtonTapped() {
        
    }
    
    @objc func registerButtonTapped() {
        print("Register")
    }
    
    @objc private func checkboxButtonTapped() {
            checkboxButton.isSelected.toggle()
        }
    
    @objc private func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genderOptions[row]
        genderTextField.resignFirstResponder()
    }
    
    
}
