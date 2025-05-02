//
//  SplashViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 5/1/25.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 앱 로고 이미지 표시
        let logoImageView = UIImageView(image: .launch)
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)

        logoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // 1초 후에 로그인 화면으로 자연스럽게 페이드 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.transitionToLogin()
        }
    }

    private func transitionToLogin() {
        // 현재 앱에서 활성화된(사용 중인) 장면(Scene)을 찾음. 여러 Scene이 있을 수 있으므로 가장 앞의 활성 Scene만 선택
        guard let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            
            // 해당 Scene에서 연결된 첫 번째 윈도우를 가져옴
            let window = windowScene.windows.first else {
            // 위 둘 중 하나라도 실패하면 함수 종료
            return
        }
        
        // 로그인 화면(LoginViewController)을 생성
        let loginVC = LoginViewController()
        
        // 로그인 화면을 네비게이션 컨트롤러에 포함시킴 (뒤로가기 버튼 등 네비게이션 기능을 위해)
        let navController = UINavigationController(rootViewController: loginVC)
        
        // 창(window) 전환 애니메이션 설정: 크로스 디졸브 방식(부드럽게 전환)
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            // 애니메이션 안에서 루트 뷰 컨트롤러를 로그인 화면으로 변경
            window.rootViewController = navController
        }, completion: nil) // 애니메이션 완료 후 별도 작업 없음
    }

}

