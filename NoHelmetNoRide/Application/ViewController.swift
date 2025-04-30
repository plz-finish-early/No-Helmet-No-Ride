//
//  ViewController.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .main

        // 로그인 화면으로 시작
        let loginVC = LoginViewController()
        let vc = UINavigationController(rootViewController: loginVC)
        setup(vc)
    }
    
    func setup(_ child: UIViewController) {
        addChild(child) // 자식 뷰 추가 (자식 뷰: LoginViewController)
        self.view.addSubview(child.view)
        
        // 제약 설정
        child.view.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // 자식 뷰를 부모 뷰에 추가가 완료 되었다고 시스템에 알려주는 메서드
        // 이 호출이 없으면 뷰 컨트롤러 라이프 사이클이 꼬일 수 있음.
        child.didMove(toParent: self)
    }
}
