//
//  MyPageViewController.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    // MARK: - UI요소
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["지도", "킥보드 등록", "마이페이지"])
        sc.selectedSegmentIndex = 2
        sc.backgroundColor = .white
        sc.selectedSegmentTintColor = .systemGray5
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        sc.setTitleTextAttributes([.font: font, .foregroundColor: UIColor.black], for: .normal)
        sc.setTitleTextAttributes([.font: font, .foregroundColor: UIColor.black], for: .selected)
        return sc
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이정진레모니 님"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이용 내역 >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이용 현황 >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let registeredKickboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("등록한 킥보드 >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let logoutButton = mainButton(title: "로그아웃")
    
    // MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        configureSegmentControl()
    }
    
    // MARK: - 레이아웃 세팅
    
    private func setupLayout() {
        view.addSubview(segmentedControl)
        view.addSubview(nameLabel)
        view.addSubview(historyButton)
        view.addSubview(statusButton)
        view.addSubview(registeredKickboardButton)
        view.addSubview(logoutButton)
        logoutButton.backgroundColor = UIColor(named: "Sub2")
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
        }
        
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(historyButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        registeredKickboardButton.snp.makeConstraints { make in
            make.top.equalTo(statusButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - 세그먼트 액션 연결
    
    private func configureSegmentControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("지도 이동")
        case 1:
            print("킥보드 등록 이동")
        case 2:
            print("마이페이지 현재 화면")
        default:
            break
        }
    }
}
