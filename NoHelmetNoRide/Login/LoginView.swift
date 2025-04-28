//
//  LoginView.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit
import SnapKit

class LoginView: UIView {
    let titleLabel = UILabel()
    let welcomeLabel = UILabel()
    let idTextView = UITextView()
    let idUnderLineView = UIView()
    let passwordTextView = UITextView()
    let passwordUnderLineView = UIView()
    let signUpButton = UIButton()
    let loginButton = UIButton()
    // 찬호박님 버튼 사용
    let mainButton = MainButton(title: "로그인")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        // titleLabel 속성 설정
        self.titleLabel.text = "로그인"
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 32)
        self.titleLabel.textAlignment = .left
        
        self.addSubview(self.titleLabel)
        
        // 제약 설정
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.width.equalTo(129)
            $0.height.equalTo(40)
        }
        
        // welcomeLabel 설정
        self.welcomeLabel.text = "명심하세요,\n노(NO) 안전모는\n운전할 수 없습니다.\n \n안전모는 선택이 아니라 필수입니다."
        self.welcomeLabel.textColor = .black
        self.welcomeLabel.font = .systemFont(ofSize: 16)
        self.welcomeLabel.textAlignment = .left
        self.welcomeLabel.numberOfLines = 0
        
        self.addSubview(self.welcomeLabel)
        
        // 제약 설정
        self.welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.width.equalTo(240)
            $0.height.equalTo(100)
        }
        
        // idTextView 설정
        self.idTextView.font = .systemFont(ofSize: 17)
        self.idTextView.text = "아이디"
        self.idTextView.textColor = .lightGray
        self.idTextView.textContainerInset = .init(top: 11, left: 0, bottom: 11, right: 0)
        
        self.addSubview(self.idTextView)
        
        // 제약 설정
        self.idTextView.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(70)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(28)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(44)
        }
        
        // idUnderLineView
        self.idUnderLineView.backgroundColor = UIColor.lightGray
        
        self.addSubview(idUnderLineView)
        
        // 제약 설정
        self.idUnderLineView.snp.makeConstraints {
            $0.top.equalTo(idTextView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(34)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(1)
        }
        
        // passwordTextView
        self.passwordTextView.font = .systemFont(ofSize: 17)
        self.passwordTextView.text = "비밀번호"
        self.passwordTextView.textColor = .lightGray
        self.passwordTextView.textContainerInset = .init(top: 11, left: 0, bottom: 11, right: 0)
        
        self.addSubview(self.passwordTextView)
        
        // 제약 설정
        self.passwordTextView.snp.makeConstraints {
            $0.top.equalTo(idUnderLineView.snp.bottom).offset(32)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(28)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(44)
        }
        
        // passwordUnderLineView
        self.passwordUnderLineView.backgroundColor = UIColor.lightGray
        
        self.addSubview(passwordUnderLineView)
        
        // 제약 설정
        self.passwordUnderLineView.snp.makeConstraints {
            $0.top.equalTo(passwordTextView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(34)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(1)
        }
        
        // signUpButton
        self.signUpButton.setTitle("회원가입", for: .normal)
        self.signUpButton.setTitleColor(.black, for: .normal)
        self.signUpButton.backgroundColor = .white
        self.signUpButton.titleLabel?.font = .systemFont(ofSize: 15)
        
        self.addSubview(signUpButton)
        
        // 제약 설정
        self.signUpButton.snp.makeConstraints {
            $0.top.equalTo(passwordUnderLineView.snp.bottom).offset(42)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(22)
        }
        
        // loginButton
//        self.loginButton.setTitle("로그인", for: .normal)
//        self.loginButton.setTitleColor(.black, for: .normal)
//        self.loginButton.backgroundColor = .yellow // F1B837
//        self.loginButton.titleLabel?.font = .systemFont(ofSize: 24)
//        self.loginButton.layer.cornerRadius = 20
//        
//        self.addSubview(loginButton)
//        
//        // 제약 설정
//        self.loginButton.snp.makeConstraints {
//            //$0.top.equalTo(signUpButton.snp.bottom).offset(168)
//            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
//            $0.centerX.equalTo(self.safeAreaLayoutGuide)
//            $0.width.equalTo(350)
//            $0.height.equalTo(80)
//        }
        
        self.addSubview(mainButton)
        
        // 제약 설정
        self.mainButton.snp.makeConstraints {
            //$0.top.equalTo(signUpButton.snp.bottom).offset(168)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(350)
            $0.height.equalTo(80)
        }

    }
}

