//
//  MyPageViewController.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit

class MyPageViewController: UIViewController {
    
    private let myPageView = MyPageView()
    
    override func loadView() {
        self.view = myPageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHistoryButtonAction()
        addStatusButtonAction()
        addKickboardButtonAction()
        addLogoutButtonAction()
    }
    
    // 이용 내역
    func addHistoryButtonAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedHistoryButton))
        myPageView.historyStack.addGestureRecognizer(tap)
    }
    
    @objc func didTappedHistoryButton() {
        let usageHistoryViewController = UsageHistoryViewController()
        navigationController?.pushViewController(usageHistoryViewController, animated: true)
    }
    
    // 이용 현황
    func addStatusButtonAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedStatusButton))
        myPageView.statusStack.addGestureRecognizer(tap)
    }
    
    @objc func didTappedStatusButton() {
        let usageStatusViewController = UsageStatusViewController(status: .using)
        presentModal(usageStatusViewController)
    }
    
    // 등록된 킥보드
    func addKickboardButtonAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedKickboardButton))
        myPageView.kickboardStack.addGestureRecognizer(tap)
    }
    
    @objc func didTappedKickboardButton() {
        let registeredKickboardViewController = RegisteredKickboardViewController()
        navigationController?.pushViewController(registeredKickboardViewController, animated: true)
    }
    
    func addLogoutButtonAction() {
        myPageView.logoutButton.addTarget(self, action: #selector(didTappedLogoutButton), for: .touchUpInside)
    }
    
    // 새로 추가
    @objc func didTappedLogoutButton() {
        //let vc = LoginViewController()
        //navigationController?.pushViewController(vc, animated: true)
        navigationController?.popViewController(animated: true)
    }
}
