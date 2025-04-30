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
}
