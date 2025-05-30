//
//  RegisteredKickboardViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit
import SnapKit

class RegisteredKickboardViewController: UIViewController {
    let registeredKickboardView = RegisteredKickboardView()
    
    var kickboardList: [KickboardData] = [] {
        didSet {
            registeredKickboardView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = registeredKickboardView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

//        let currentUserID = LoginViewController.shared.loginUserID
//        kickboardList = CoreDataManager.shared.fetchKickboardData(for: currentUserID) 유저가 등록한 킥보드으로 표시 X
        kickboardList = CoreDataManager.shared.fetchKickboardData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTableView()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "등록한 킥보드"
    }
    
    func setupTableView() {
        registeredKickboardView.tableView.delegate = self
        registeredKickboardView.tableView.dataSource = self
        registeredKickboardView.tableView.register(RegisteredKickboardCell.self, forCellReuseIdentifier: "cell")
    }
    
    // 날짜 포맷 함수
    func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "날짜 없음" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
}

// MARK: - 테이블 뷰 데이터 소스, 델리게이트 설정
extension RegisteredKickboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        134
    }
    
}

extension RegisteredKickboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kickboardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RegisteredKickboardCell else { return UITableViewCell() }
        
        let kickboard = kickboardList[indexPath.row]
         cell.selectionStyle = .none

         cell.kickBoardIdDataLabel.text = kickboard.kickboardID ?? "미입력"
         cell.registeredDateDataLabel.text = formatDate(kickboard.registrationDate)

        let time = Int(kickboard.totalUsageTime)
        print(time)
        let minutes = time / 60
        let seconds = time % 60
        let usageKm = Double(kickboard.totalUsageDistance) / 1000.0
        print(minutes, seconds)
        cell.totalDriveDataLabel.text = String(format: "%02d분 %02d초, %.1fKM", minutes, seconds, usageKm)
        
        //cell 선택시 선택효과 제거
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        // 실제 값 전달
        cell.configure(with: kickboard)
        
        return cell
    }
    
    
}
