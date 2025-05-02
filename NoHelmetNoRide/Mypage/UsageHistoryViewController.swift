//
//  UsageHistoryViewController.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit

class UsageHistoryViewController: UIViewController {
    private let usageHistoryView = UsageHistoryView()
    
    var usageHistoryList: [UserUsageInfo] = []
    
    override func loadView() {
        self.view = usageHistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

        let currentUserID = LoginViewController.shared.loginUserID

        // 더미 데이터 삭제
        let allUsageList = CoreDataManager.shared.fetchUsageInfos(for: currentUserID)
        for info in allUsageList {
            if info.kickboardID == "K001" || info.kickboardID == "test1234" || info.kickboardID == "킥보드 ID" {
                CoreDataManager.shared.deleteUsageInfo(info: info)
            }
        }

        // 삭제 후 리스트 새로 불러오기
        usageHistoryList = CoreDataManager.shared.fetchUsageInfos(for: currentUserID)
        usageHistoryView.tableView.reloadData()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "이용 내역"
    }
    
    private func setupTableView() {
        usageHistoryView.tableView.delegate = self
        usageHistoryView.tableView.dataSource = self
        usageHistoryView.tableView.register(UsageHistoryCell.self, forCellReuseIdentifier: "UsageHistoryCell")
    }
    
    // 날짜 포맷 함수
    func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "날짜 없음" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
}

extension UsageHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}

extension UsageHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usageHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsageHistoryCell", for: indexPath) as? UsageHistoryCell else {
            return UITableViewCell()
        }
        let info = usageHistoryList[indexPath.row]
            cell.selectionStyle = .none

            cell.kickboardIdLabel.text = "킥보드 ID: \(info.kickboardID ?? "알 수 없음")"
            cell.dateLabel.text = "날짜: \(formatDate(info.usageDate))"
            
            let minutes = Int(info.usageTime)
            let distance = Double(info.usageDistance) / 1000.0
            cell.drivingInfoLabel.text = String(format: "운행: %d분, %.1fKM", minutes, distance)
            
            cell.priceLabel.text = "요금: \(info.usageAmount)원"
        
        //cell 선택시 선택효과 제거
        cell.selectionStyle = UITableViewCell.SelectionStyle.none


        return cell
    }
}
