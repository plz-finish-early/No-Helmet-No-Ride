//
//  SignUpViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit
import CoreData

class SignUpViewController: UIViewController {
    let signUpView = SignUpView()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSignUpButtonAction()
        addCancelButtonAction()
        checkID() // 아이디 입력 식별
        checkNickName()
        checkPW()
        checkEqualPW()
    }
    
    // 소문자 영어와 숫자 조합 문자열 검사
    func isValidID(_ id: String) -> Bool {
        /*
         (?=.*[a-z]) → 소문자 영문이 반드시 하나 이상
         (?=.*[0-9]) → 숫자가 반드시 하나 이상
         [a-z0-9]+ → 전체 문자는 소문자나 숫자로만 구성
         */
        let pattern = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: id)
    }
    
    // 닉네임 검사
    func isValidNickname(_ nickname: String) -> Bool {
        /*
         ^ : 문자열 시작
         [가-힣] : 한글 범위 (가 ~ 힣)
         {1,6} : 1자 이상 6자 이하
         $ : 문자열 끝
         */
        let pattern = "^[가-힣]{1,6}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: nickname)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let pattern = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{8,16}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
    }
    
    func isValidCheckPassword() -> Bool {
        return signUpView.passwordTextField.text == signUpView.passwordCheckTextField.text
    }
    
    private func checkID() {
        signUpView.idTextField.addAction(UIAction(handler: { _ in
            let idText = self.signUpView.idTextField.text ?? ""

            if idText.isEmpty {
                self.signUpView.guideIdLabel.text = "아이디를 입력하지 않았습니다."
                self.signUpView.guideIdLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
                return
            }

            let result = CoreDataManager.shared.fetchUserID(userID: idText)

            if result != nil {
                self.signUpView.guideIdLabel.text = "이미 등록된 아이디입니다."
                self.signUpView.guideIdLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
            } else if self.isValidID(idText) {
                self.signUpView.guideIdLabel.text = "등록 가능한 아이디입니다."
                self.signUpView.guideIdLabel.textColor = .font
                self.signUpView.mainButton.isEnabled = true
                self.signUpView.mainButton.backgroundColor = .main
            } else {
                self.signUpView.guideIdLabel.text = "아이디는 소문자 영문과 숫자만 사용 가능합니다."
                self.signUpView.guideIdLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
            }
        }), for: .editingChanged)
    }
    
    private func checkNickName() {
        signUpView.nickNameTextField.addAction(UIAction(handler: { _ in
            let nickNameText = self.signUpView.nickNameTextField.text ?? ""

            if nickNameText.isEmpty {
                self.signUpView.guideNickNameLabel.text = "닉네임을 입력하지 않았습니다."
                self.signUpView.guideNickNameLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
                return
            }

            let result = CoreDataManager.shared.fetchUserID(userID: nickNameText)

            if result != nil {
                self.signUpView.guideNickNameLabel.text = "이미 등록된 닉네임입니다."
                self.signUpView.guideNickNameLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
            } else if self.isValidNickname(nickNameText) {
                self.signUpView.guideNickNameLabel.text = "등록 가능한 닉네임입니다."
                self.signUpView.guideNickNameLabel.textColor = .font
                self.signUpView.mainButton.isEnabled = true
                self.signUpView.mainButton.backgroundColor = .main
            } else {
                self.signUpView.guideNickNameLabel.text = "닉네임은 한글 6자리까지 사용 가능합니다."
                self.signUpView.guideNickNameLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
            }
        }), for: .editingChanged)
    }
    
    private func checkPW() {
        signUpView.passwordTextField.addAction(UIAction(handler: { _ in
            let pwText = self.signUpView.passwordTextField.text ?? ""

            if pwText.isEmpty {
                self.signUpView.guidePasswordLabel.text = "패스워드를 입력하지 않았습니다."
                self.signUpView.guidePasswordLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
                return
            }

            if self.isValidPassword(pwText) {
                self.signUpView.guidePasswordLabel.text = "사용 가능합니다."
                self.signUpView.guidePasswordLabel.textColor = .font
                self.signUpView.mainButton.isEnabled = true
                self.signUpView.mainButton.backgroundColor = .main
            } else {
                self.signUpView.guidePasswordLabel.text = "소문자 영문과 숫자 조합 최소 8자리, 최대 16자리까지 사용 가능합니다."
                self.signUpView.guidePasswordLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
            }
        }), for: .editingChanged)
    }
    
    private func checkEqualPW() {
        signUpView.passwordCheckTextField.addAction(UIAction(handler: { _ in
            if self.isValidCheckPassword() {
                self.signUpView.guidePasswordCheckLabel.text = "패스워드가 일치합니다."
                self.signUpView.guidePasswordCheckLabel.textColor = .font
                self.signUpView.mainButton.isEnabled = true
                self.signUpView.mainButton.backgroundColor = .main
            } else {
                self.signUpView.guidePasswordCheckLabel.text = "입력한 패스워드가 일치하지 않습니다."
                self.signUpView.guidePasswordCheckLabel.textColor = .red
                self.signUpView.mainButton.isEnabled = false
                self.signUpView.mainButton.backgroundColor = .gray
            }
        }), for: .editingChanged)
    }
    
    // 가입 취소 버튼 액션
    private func addCancelButtonAction() {
        signUpView.cancelButton.addTarget(self, action: #selector(didTappedCancelButton), for: .touchUpInside)
    }
    
    @objc
    private func didTappedCancelButton() {
        self.dismissModal() // 모달 창 내리기
    }
    
    // 회원가입 버튼 액션
    private func addSignUpButtonAction() {
        signUpView.mainButton.addTarget(self, action: #selector(didTappedSignUpButton), for: .touchUpInside)
    }
    
    @objc
    private func didTappedSignUpButton() {
        // 예외처리: 아이디 입력창에 입력값이 없을 경우
        guard let id = signUpView.idTextField.text, !id.isEmpty
        else {
            let alert = UIAlertController(title: "회원 가입 실패", message: "아이디가 입력되지 않았습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let nickName = signUpView.nickNameTextField.text, !nickName.isEmpty
        else {
            let alert = UIAlertController(title: "회원 가입 실패", message: "닉네임이 입력되지 않았습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let password = signUpView.passwordTextField.text, !password.isEmpty
        else {
            let alert = UIAlertController(title: "회원 가입 실패", message: "패스워드가 입력되지 않았습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard signUpView.passwordTextField.text == signUpView.passwordCheckTextField.text
        else {
            let alert = UIAlertController(title: "회원 가입 실패", message: "패스워드가 다릅니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        let result = CoreDataManager.shared.fetchUserID(userID: id)
        if result != nil {
                let alert = UIAlertController(title: "회원 가입 실패", message: "이미 등록된 아이디 입니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alert.addAction(ok)
                
                present(alert, animated: true, completion: nil)
            return
        }
        
        // 회원 가입 정보 저장
        CoreDataManager.shared.createAppUser(userID: id, nickName: nickName, password: password)
        print("가입 완료")
        
        // 테스트 용
        // 데이터 읽기
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        do {
            print(try context.fetch(request).last)
        } catch {
            print("Login Fetch Failed: \(error)")
        }
        // 테스트 용
        let alert = UIAlertController(title: "가입 완료", message: "회원 가입이 완료되었습니다.\n로그인 화면으로 이동합니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { action in
            self.dismissModal() // 모달 창 내리기
        }

        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
        //self.dismissModal() // 모달 창 내리기
        
        // TODO: 텍스트 필드의 값이 코어 데이터에 저장하는 로직 추가
        
    }
}
