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
    let ridingKickboardView = RidingKickboardView()
    let usingKickboardButton = UsingKickboardButton(title: "킥보드 이용하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSegmentedControl()
        setupUI()
        setupConstraints()
    }
    
    private func configureSegmentedControl() {
        customSegmentedControl = UISegmentedControl(items: ["지도", "킥보드 등록", "마이페이지"])
        
        customSegmentedControl.selectedSegmentIndex = 0
        
        customSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.font.withAlphaComponent(0.7),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ], for: .normal)
        
        customSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.font,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ], for: .selected)
        
        //segmentedControll 백그라운드 및 셀렉터값 모두 없애기
        customSegmentedControl.selectedSegmentTintColor = .clear
        customSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        customSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
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
        
        NSLayoutConstraint.activate([
            customSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            customSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            customSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customSegmentedControl.heightAnchor.constraint(equalToConstant: 26),
            
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 260),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ridingKickboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ridingKickboardView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: -54),
            
//            usingKickboardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            usingKickboardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            usingKickboardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}

extension MainMapViewController {
    
}
