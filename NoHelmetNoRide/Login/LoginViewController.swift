//
//  LoginViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
    }
    
    func setupTextView() {
        loginView.idTextView.delegate = self
        loginView.passwordTextView.delegate = self
    }
}

extension LoginViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if loginView.idTextView.textColor == UIColor.lightGray {
            loginView.idTextView.text = nil
            loginView.idTextView.textColor = .black
        }
        
        if loginView.passwordTextView.textColor == UIColor.lightGray {
            loginView.passwordTextView.text = nil
            loginView.passwordTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if loginView.idTextView.text.isEmpty {
            loginView.idTextView.text = "아이디"
            loginView.idTextView.textColor = .lightGray
        }
        
        if loginView.passwordTextView.text.isEmpty {
            loginView.passwordTextView.text = "비밀번호"
            loginView.passwordTextView.textColor = .lightGray
        }
    }
}

