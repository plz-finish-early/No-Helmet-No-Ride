//
//  Modal.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/30/25.
//

import Foundation
import UIKit

extension UIViewController {
    /// 어떤 뷰컨트롤러에서든 모달을 띄울 수 있는 공용 메서드
    func presentModal(_ viewController: UIViewController, style: UIModalPresentationStyle = .fullScreen, animated: Bool = true) {
        viewController.modalPresentationStyle = style // 기본은 전체 화면, 필요 시 변경 가능
        self.present(viewController, animated: animated, completion: nil) // 모달 띄우기
    }
    
    /// 현재 뷰컨트롤러를 모달로 닫는 함수
    func dismissModal(animated: Bool = true) {
        self.dismiss(animated: animated, completion: nil)
    }
}
