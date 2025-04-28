//
//  UsageHistoryView.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit
import SnapKit

class UsageHistoryView: UIView {
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        tableView.backgroundColor = .white
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(46)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
