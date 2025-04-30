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
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSignUpButtonAction() // 회원가입 버튼 액션 추가
        addLoginButtonAction() // 로그인 버튼 액션 추가
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
    
    // 로그인 버튼 액션 추가
    private func addLoginButtonAction() {
        loginView.mainButton.addTarget(self, action: #selector(didTappedLoginButtonButton), for: .touchUpInside)
    }
    
    @objc
    private func didTappedLoginButtonButton() {
        // TODO: 코어 데이터에 아이디 비밀번호 값 맞는지 확인하는 로직
        
        // TODO: 로그인 데이터가 맞으면 지도 화면으로 이동
        
        // TODO: 로그인 데이터가 맞지 않다면, 알림창 띄우기
        
        // 테스트용
        // 실패 알림창 띄우기
//        let alert = UIAlertController(title: "로그인 실패", message: "로그인에 실패하였습니다.\n아이디와 비밀번호를 확인해주세요.", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
//
//        alert.addAction(ok)
//        
//        present(alert, animated: true, completion: nil)
        
        // 마이페이지로 넘어가기
//        let vc = MyPageViewController()
//        navigationController?.pushViewController(vc, animated: true)
        
        // 매인 맵으로 넘어가기
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

