//
//  KickboardRegistrationViewController.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/28/25.
//

import UIKit
protocol RegisterViewDismissDelegate {
    func dismiss()
}

class KickboardRegistrationViewController: UIViewController {
    
    weak var delegate: KickboardRegistrationWithMap?
    
    var registedID = CoreDataManager.shared.fetchKickboardData()
    
    let registrationView = KickboardRegistrationView()
    
    var coordinate: (lat: Double, lng: Double) = (lat: 0, lng: 0)
    
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
            if let text = self.registrationView.idTextField.text {
                if CoreDataManager.shared.isKickboardRegistered(kickboardID: text) {
                    self.registrationView.idValidatorLabel.text = "이미 등록된 아이디 입니다."
                    self.registrationView.registrationButton.isEnabled = false
                    self.registrationView.registrationButton.backgroundColor = .gray
                } else {
                    self.registrationView.idValidatorLabel.text = ""
                    self.registrationView.registrationButton.isEnabled = true
                    self.registrationView.registrationButton.backgroundColor = .main
                }
            }
        }), for: .editingChanged)
    }
    
    @objc private func registrationButtonTapped() {
        guard let text = registrationView.idTextField.text, text.count != 0 else {
            let alert = UIAlertController(title: "등록실패",
                                          message: "킥보드 아이디를 입력해주세요",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            return
        }
        CoreDataManager.shared.createKickboardData(
            kickboardID: text,
            isRidingKickboard: false,
            registrationDate: Date(),
            totalUsageTime: 0,
            totalUsageDistance: 0,
            kickboardBatteryAmount: 100,
            lat: coordinate.lat,
            lng: coordinate.lng
        )
        
        let alert = UIAlertController(title: "등록완료",
                                      message: "킥보드 등록이 완료되었습니다.\n등록 초기 화면으로 이동합니다.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
        registrationView.idTextField.text = ""
        
        registedID = CoreDataManager.shared.fetchKickboardData()
        delegate?.dismiss()
    }
}

