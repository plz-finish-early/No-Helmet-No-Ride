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
        
        addButtonAction() // 버튼 액션 추가
    }
    
    private func addButtonAction() {
        loginView.signUpButton.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
    }
    
    @objc
    private func didTappedButton() {
        let modalVC = SignUpViewController() // 모달로 띄울 뷰 컨트롤러 설정
        modalVC.modalPresentationStyle = .fullScreen // 풀 스크린 모달 스타일로 설정
        self.present(modalVC, animated: true, completion: nil) // 모달 띄우기
    }
}

