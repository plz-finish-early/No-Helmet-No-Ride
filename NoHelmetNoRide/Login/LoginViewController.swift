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
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSignUpButtonAction() // 회원가입 버튼 액션 추가
    }
    
    // 회원가입 버튼 액션 추가
    private func addSignUpButtonAction() {
        loginView.signUpButton.addTarget(self, action: #selector(didTappedSignUpButtonButton), for: .touchUpInside)
    }
    
    @objc
    private func didTappedSignUpButtonButton() {
        let signUpVC = SignUpViewController() // 모달로 띄울 뷰 컨트롤러 설정
        self.presentModal(signUpVC)
    }
    }
}

