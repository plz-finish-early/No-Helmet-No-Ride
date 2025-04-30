//
//  SignUpViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit

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
