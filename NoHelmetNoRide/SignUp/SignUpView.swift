//
//  SignUpView.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation

import Foundation
import UIKit
import SnapKit

class SignUpView: UIView {
    // MARK: - Property
    let titletLabel = UILabel()
    let idTextField = UITextField()
    let idUnderLineView = UIView()
    let guideIdLabel = UILabel()
    let nickNameTextField = UITextField()
    let nickNameUnderLineView = UIView()
    let guideNickNameLabel = UILabel()
    let passwordTextField = UITextField()
    let passwordUnderLineView = UIView()
    let guidePasswordLabel = UILabel()
    let passwordCheckTextField = UITextField()
    let passwordCheckUnderLineView = UIView()
    let guidePasswordCheckLabel = UILabel()
    let mainButton = MainButton(title: "회원가입")
    
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
        // 타이틀 라벨 설정
        self.titletLabel.text = "회원가입"
        self.titletLabel.textColor = .black
        self.titletLabel.textAlignment = .left
        self.titletLabel.font = .systemFont(ofSize: 32)
        
        self.addSubview(titletLabel)
        
        // 제약 설정
        titletLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(40)
        }
        
        // 아이디 입력 칸
        self.idTextField.font = .systemFont(ofSize: 17)
        self.idTextField.placeholder = "아이디"
        self.idTextField.clearButtonMode = .whileEditing // 입력 중 x 버튼 생성
        
        self.addSubview(idTextField)
        
        // 제약 설정
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titletLabel.snp.bottom).offset(62)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }
        
        // 아이디 밑줄
        self.idUnderLineView.layer.borderWidth = 1
        self.idUnderLineView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(idUnderLineView)
        
        // 제약 설정
        idUnderLineView.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(1)
        }
        
        // 아이디 안내 글
        self.guideIdLabel.text = "아이디는 영문과 숫자만 입력이 가능합니다."
        self.guideIdLabel.textColor = .font
        self.guideIdLabel.textAlignment = .left
        self.guideIdLabel.font = .systemFont(ofSize: 12)
        
        self.addSubview(guideIdLabel)
        
        // 제약 설정
        guideIdLabel.snp.makeConstraints {
            $0.top.equalTo(idUnderLineView.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(22)
        }
        
        
        // 닉네임 입력 칸
        self.nickNameTextField.font = .systemFont(ofSize: 17)
        self.nickNameTextField.placeholder = "닉네임"
        self.nickNameTextField.clearButtonMode = .whileEditing // 입력 중 x 버튼 생성
        
        self.addSubview(nickNameTextField)
        
        // 제약 설정
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(guideIdLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }
        
        // 닉네임 밑줄
        self.nickNameUnderLineView.layer.borderWidth = 1
        self.nickNameUnderLineView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(nickNameUnderLineView)
        
        // 제약 설정
        nickNameUnderLineView.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(1)
        }
        
        // 닉네임 안내 글
        self.guideNickNameLabel.text = "닉네임은 한글 6자리까지 가능합니다."
        self.guideNickNameLabel.textColor = .font
        self.guideNickNameLabel.textAlignment = .left
        self.guideNickNameLabel.font = .systemFont(ofSize: 12)
        
        self.addSubview(guideNickNameLabel)
        
        // 제약 설정
        guideNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameUnderLineView.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(22)
        }
        
        // 비밀번호 입력 칸
        self.passwordTextField.font = .systemFont(ofSize: 17)
        self.passwordTextField.placeholder = "비밀번호"
        self.passwordTextField.clearButtonMode = .whileEditing // 입력 중 x 버튼 생성
        
        self.addSubview(passwordTextField)
        
        // 제약 설정
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(guideNickNameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }
        
        // 닉네임 밑줄
        self.passwordUnderLineView.layer.borderWidth = 1
        self.passwordUnderLineView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(passwordUnderLineView)
        
        // 제약 설정
        passwordUnderLineView.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(1)
        }
        
        // 닉네임 안내 글
        self.guidePasswordLabel.text = "비밀번호는 영문과 숫자 10자리 내로 입력이 가능합니다."
        self.guidePasswordLabel.textColor = .font
        self.guidePasswordLabel.textAlignment = .left
        self.guidePasswordLabel.font = .systemFont(ofSize: 12)
        
        self.addSubview(guidePasswordLabel)
        
        // 제약 설정
        guidePasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordUnderLineView.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(22)
        }
        
        // 비밀번호 확인 입력 칸
        self.passwordCheckTextField.font = .systemFont(ofSize: 17)
        self.passwordCheckTextField.placeholder = "비밀번호 확인"
        self.passwordCheckTextField.clearButtonMode = .whileEditing // 입력 중 x 버튼 생성
        
        self.addSubview(passwordCheckTextField)
        
        // 제약 설정
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(guidePasswordLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }
        
        // 닉네임 밑줄
        self.passwordCheckUnderLineView.layer.borderWidth = 1
        self.passwordCheckUnderLineView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(passwordCheckUnderLineView)
        
        // 제약 설정
        passwordCheckUnderLineView.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTextField.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(1)
        }
        
        // 닉네임 안내 글
        self.guidePasswordCheckLabel.text = "비밀번호가 일치하지 않습니다."
        self.guidePasswordCheckLabel.textColor = .font
        self.guidePasswordCheckLabel.textAlignment = .left
        self.guidePasswordCheckLabel.font = .systemFont(ofSize: 12)
        
        self.addSubview(guidePasswordCheckLabel)
        
        // 제약 설정
        guidePasswordCheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordCheckUnderLineView.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.height.equalTo(22)
        }
        
        // 회원 가입 버튼
        self.addSubview(mainButton)
        
        // 제약 설정
        mainButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(12)
        }

    }
}
