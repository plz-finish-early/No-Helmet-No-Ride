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
            let alert = UIAlertController(title: "회원 가입 실패", message: "ID가 입력되지 않았습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let nickName = signUpView.nickNameTextField.text, !nickName.isEmpty
        else {
            let alert = UIAlertController(title: "회원 가입 실패", message: "nickName이 입력되지 않았습니다.", preferredStyle: .alert)
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
