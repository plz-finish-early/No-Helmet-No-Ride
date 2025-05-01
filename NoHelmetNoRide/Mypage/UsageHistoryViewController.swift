//
//  UsageHistoryViewController.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit

class UsageHistoryViewController: UIViewController {
    private let usageHistoryView = UsageHistoryView()
    
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
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "이용 내역"
    }
    
    private func setupTableView() {
        usageHistoryView.tableView.delegate = self
        usageHistoryView.tableView.dataSource = self
        usageHistoryView.tableView.register(UsageHistoryCell.self, forCellReuseIdentifier: "UsageHistoryCell")
    }
}

extension UsageHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}

extension UsageHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsageHistoryCell", for: indexPath) as? UsageHistoryCell else {
            return UITableViewCell()
        }
        
        //cell 선택시 선택효과 제거
        cell.selectionStyle = UITableViewCell.SelectionStyle.none


        return cell
    }
}
