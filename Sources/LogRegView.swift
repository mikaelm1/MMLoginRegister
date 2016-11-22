//
//  LogRegView.swift
//  MMLoginRegister
//
//  Created by Mikael Mukhsikaroyan on 11/21/16.
//  Copyright © 2016 MSquaredmm. All rights reserved.
//

import UIKit

public protocol LogRegViewDelegate {
    func register(withPassword password: String, username: String, email: String)
    func login(withPassword password: String, username: String)
}

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

public class LogRegView: UIView {
    
    // MARK: - Properties
    
    public lazy var passwordField: CustomTextField = {
        let t = CustomTextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.placeholder = "Enter password"
        t.isSecureTextEntry = true
        return t
    }()
    
    public lazy var usernameField: CustomTextField = {
        let t = CustomTextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.placeholder = "Enter username"
        t.autocapitalizationType = .none
        t.autocorrectionType = .no
        return t
    }()
    
    public lazy var emailField: CustomTextField = {
        let t = CustomTextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textContentType = UITextContentType.emailAddress
        t.delegate = self
        t.placeholder = "Enter email"
        t.autocapitalizationType = .none
        t.autocorrectionType = .no
        return t
    }()
    
    public lazy var registerButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor(red: 230/255, green: 79/255, blue: 76/255, alpha: 1)
        b.setTitle("Register", for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        b.setTitleColor(.white, for: [])
        return b
    }()
    
    public lazy var loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .clear
        b.setTitle("Login", for: [])
        b.addTarget(self, action: #selector(switchLoginForm(sender:)), for: .touchUpInside)
        b.setTitleColor(.white, for: [])
        return b
    }()
    
    let fieldContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.masksToBounds = true
        return v
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 1
        sv.axis = .vertical
        return sv
    }()
    
    var registering = true
    var stackViewHeight: NSLayoutConstraint?
    public var delegate: LogRegViewDelegate?
    public var fieldColor: UIColor = .white {
        didSet {
            setField(color: fieldColor)
        }
    }
    
    // MARK: - Initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 44/255, green: 61/255, blue: 78/255, alpha: 1)
        setupViews()
        setField(color: .white)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Views
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func setField(color: UIColor) {
        fieldContainer.backgroundColor = color
        usernameField.backgroundColor = color
        passwordField.backgroundColor = color
        emailField.backgroundColor = color
    }
    
    func setupViews() {
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        stackViewHeight = stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.21)
        stackViewHeight?.isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
        addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        registerButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 8).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    // MARK: - Actions
    
    func switchLoginForm(sender: UIButton) {
        
        UIView.animate(withDuration: 0.15) {
            self.stackViewHeight?.isActive = false
            self.stackViewHeight = self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: self.registering ? 0.14 : 0.21)
            self.stackViewHeight?.isActive = true
            
            self.emailField.isHidden = self.registering ? true : false
            
            self.layoutIfNeeded()
        }
        
        if registering {
            let temp = registerButton.titleLabel?.text
            registerButton.setTitle(loginButton.titleLabel?.text, for: [])
            loginButton.setTitle(temp, for: [])
        } else {
            let temp = registerButton.titleLabel?.text
            registerButton.setTitle(loginButton.titleLabel?.text, for: [])
            loginButton.setTitle(temp, for: [])
        }
        
        registering = !registering
    }
    
    func loginButtonTapped(sender: UIButton) {
        // If fields are valid, then they have text in them. Safe to force unwrap
        if registering {
            if fieldsValid() {
                delegate?.register(withPassword: passwordField.text!, username: usernameField.text!, email: emailField.text!)
            }
        } else {
            if fieldsValid() {
                delegate?.login(withPassword: passwordField.text!, username: usernameField.text!)
            }
        }
    }
    
    // MARK: - Helper
    
    func fieldsValid() -> Bool {
        var fields = [usernameField, passwordField]
        if registering {
            fields.append(emailField)
        }
        var valid = true
        for field in fields {
            if field.text!.isBlank {
                field.errorMode()
                valid = false
            }
        }
        return valid
    }
    
}

extension LogRegView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! CustomTextField).normalMode()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text!.isBlank {
            (textField as! CustomTextField).errorMode()
        }
        
    }
    
}

