//
//  MainMapViewController.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/28/25.
//

import UIKit
import SnapKit

class MainMapViewController: UIViewController {
    var customSegmentedControl = UISegmentedControl()
    let bottomSheetView = CustomBottomSheetView()
    // 바텀시트(Bottom Sheet) 뷰의 위치를 제어하는 오토레이아웃(NSLayoutConstraint) 제약조건
    var bottomSheetViewBottomConstraint: NSLayoutConstraint!
    let ridingKickboardView = RidingKickboardView()
    let usingKickboardButton = UsingKickboardButton(title: "킥보드 이용하기")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        setupConstraints()
        
        bottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 260 // 초기에는 화면 밖에 위치
        )
        
        bottomSheetView.delegate = self
        bottomSheetViewBottomConstraint?.isActive = true
        // 바텀시트를 뷰의 계층 가장 상단에 위치하게
        view.bringSubviewToFront(bottomSheetView)
    }
    
    private func showBottomSheet() {
        bottomSheetViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideBottomSheet() {
        guard bottomSheetViewBottomConstraint?.constant == 0 else { return }
        
        bottomSheetViewBottomConstraint?.constant = 260
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        [
            customSegmentedControl,
            bottomSheetView,
            ridingKickboardView,
            usingKickboardButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        // 높이 제약 추가
        ridingKickboardView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // 상단 위치 제약 추가
        ridingKickboardView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        // 기존 제약
        let c1 = ridingKickboardView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: -54)
        c1.priority = .defaultHigh

        let c2 = ridingKickboardView.bottomAnchor.constraint(greaterThanOrEqualTo: usingKickboardButton.topAnchor, constant: -116)
        c2.priority = .required

        NSLayoutConstraint.activate([c1, c2])

        NSLayoutConstraint.activate([
            customSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            customSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            customSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customSegmentedControl.heightAnchor.constraint(equalToConstant: 26),
            
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 260),
            
            ridingKickboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            usingKickboardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            usingKickboardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            usingKickboardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}

extension MainMapViewController: CustomBottomSheetViewDelegate {
    func didRequestHide() {
        hideBottomSheet()
    }
}
