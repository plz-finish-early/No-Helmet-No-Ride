//
//  KickboardRegistrationViewController.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/28/25.
//

import UIKit

class KickboardRegistrationViewController: UIViewController {
    
    let registedID = "12345"
    
    let registrationView = KickboardRegistrationView()
    
    override func loadView() {
        super.loadView()
        self.view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registrationView.underLine.frame = CGRect(x: 0,
                                                           y:registrationView.idTextField.frame.height,
                                                           width:registrationView.idTextField.frame.width,
                                                           height: 1)
    }
    
    func configureAction() {
        
        registrationView.registrationButton.addTarget(self,
                                                               action: #selector(registrationButtonTapped), for: .touchUpInside)
        
        registrationView.idTextField.addAction(UIAction(handler: { _ in
            if self.registrationView.idTextField.text == self.registedID {
                self.registrationView.idValidatorLabel.text = "이미 등록된 아이디 입니다."
                self.registrationView.registrationButton.isEnabled = false
                self.registrationView.registrationButton.backgroundColor = .gray
            } else {
                self.registrationView.idValidatorLabel.text = ""
                self.registrationView.registrationButton.isEnabled = true
                self.registrationView.registrationButton.backgroundColor = .main
            }
        }), for: .editingChanged)
    }
    
    @objc private func registrationButtonTapped() {
        let alert = UIAlertController(title: "등록완료",
                                      message: "킥보드 등록이 완료되었습니다.\n등록 초기 화면으로 이동합니다.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
}
