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
    // MARK: - Property
    let titleLabel = UILabel()
    let iconImageView = UIImageView()
    let subTitleLabel = UILabel()
    let idTextField = UITextField()
    let idUnderLineView = UIView()
    let passwordTextView = UITextView()
    let passwordTextField = UITextField()
    let passwordUnderLineView = UIView()
    let signUpButton = UIButton()
    // 찬호박님 버튼, 로그인 버튼
    let mainButton = MainButton(title: "로그인")
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func setupView() {
        self.backgroundColor = .white
        
        // 타이틀 속성 설정
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
        
        // 아이콘 설정
        self.iconImageView.image = .icon
        self.iconImageView.contentMode = .scaleAspectFill
        
        self.addSubview(self.iconImageView)
        
        // 제약 설정
        self.iconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(93)
        }
        
        // subTitleLabel 설정
        self.subTitleLabel.text = "명심,\n노(NO) 헬멧은\n운전불가"
        self.subTitleLabel.textColor = .black
        self.subTitleLabel.font = .systemFont(ofSize: 14)
        self.subTitleLabel.textAlignment = .center
        self.subTitleLabel.numberOfLines = 0
        
        self.addSubview(self.subTitleLabel)
        
        // 제약 설정
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(12)
            //$0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(214)
            $0.height.equalTo(50)
        }
        
        // idTextField 설정
        self.idTextField.font = .systemFont(ofSize: 17)
        self.idTextField.placeholder = "아이디"
        //self.idTextField.
        
        self.addSubview(self.idTextField)
        
        // 제약 설정
        self.idTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(70)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(34)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(44)
        }
        
        // idUnderLineView
        self.idUnderLineView.backgroundColor = UIColor.lightGray
        
        self.addSubview(idUnderLineView)
        
        // 제약 설정
        self.idUnderLineView.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(34)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(1)
        }
        
        
        // passwordTextField 설정
        self.passwordTextField.font = .systemFont(ofSize: 17)
        self.passwordTextField.placeholder = "비밀번호"
        
        self.addSubview(self.passwordTextField)
        
        // 제약 설정
        self.passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idUnderLineView.snp.bottom).offset(32)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(34)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(44)
        }
        
        // passwordUnderLineView
        self.passwordUnderLineView.backgroundColor = UIColor.lightGray
        
        self.addSubview(passwordUnderLineView)
        
        // 제약 설정
        self.passwordUnderLineView.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom)
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
        
        // 로그인 버튼 추가
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
