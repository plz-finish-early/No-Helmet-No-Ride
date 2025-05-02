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
        
        // 마이페이지 닉네임을 로그인 계정의 닉네임으로 변경
        myPageView.nameLabel.text = LoginViewController.shared.loginNickName
        
        // 네비게이션 뒤로 버튼 커스터마이징 코드
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    // 이용 내역
    func addHistoryButtonAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedHistoryButton))
        myPageView.historyStack.addGestureRecognizer(tap)
        
    }
    
    @objc func didTappedHistoryButton() {
        let usageHistoryViewController = UsageHistoryViewController()
        let testUserID = "testUser"
        let usageList = CoreDataManager.shared.fetchUsageInfos(for: testUserID)
        usageHistoryViewController.usageHistoryList = usageList
 
        navigationController?.pushViewController(usageHistoryViewController, animated: true)
    }
    
    // 이용 현황
    func addStatusButtonAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedStatusButton))
        myPageView.statusStack.addGestureRecognizer(tap)
    }
    
    @objc func didTappedStatusButton() {
        let currentUserID = LoginViewController.shared.loginUserID
        
        if let kickboard = CoreDataManager.shared.fetchInUseKickboards(for: currentUserID) {
            let vc = UsageStatusViewController(status: .using)
            vc.kickboard = kickboard
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = UsageStatusViewController(status: .empty)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // 등록된 킥보드
    func addKickboardButtonAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedKickboardButton))
        myPageView.kickboardStack.addGestureRecognizer(tap)
    }
    
    @objc func didTappedKickboardButton() {
        let registeredKickboardViewController = RegisteredKickboardViewController()
        registeredKickboardViewController.kickboardList = CoreDataManager.shared.fetchKickboardData()
        navigationController?.pushViewController(registeredKickboardViewController, animated: true)
    }
    
    // 로그아웃 버튼
    func addLogoutButtonAction() {
        myPageView.logoutButton.addTarget(self, action: #selector(didTappedLogoutButton), for: .touchUpInside)
    }
    
    @objc func didTappedLogoutButton() {
        //let vc = LoginViewController()
        //navigationController?.pushViewController(vc, animated: true)
        
        // TODO: - pop을 이용한게 아닌, 로그인 뷰로 넘어가게 하기
        navigationController?.popViewController(animated: true)
        
        // 계정 정보 초기화
        // TODO: - 함수로 만들기
        LoginViewController.shared.loginUserID = ""
        LoginViewController.shared.loginNickName = ""
    }
}
