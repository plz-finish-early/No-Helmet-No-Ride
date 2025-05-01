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
    
    var kickboardList: [KickboardData] = []
    
    override func loadView() {
        self.view = registeredKickboardView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
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

         let usageMinutes = Int(kickboard.totalUsageTime)
         let usageKm = Double(kickboard.totalUsageDistance) / 1000.0
         cell.totalDriveDataLabel.text = String(format: "%d분 %.1fKm", usageMinutes, usageKm)
        
        //cell 선택시 선택효과 제거
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    
}
