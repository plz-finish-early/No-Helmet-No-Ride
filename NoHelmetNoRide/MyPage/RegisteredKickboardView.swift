//
//  RegisteredKickboardView.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit
import SnapKit

class RegisteredKickboardView: UIView {
    //MARK: - Property
    let tableView = UITableView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func setupView() {
        self.backgroundColor = .white
        // 테이블 뷰 설정
        self.tableView.backgroundColor = .white
        
        self.addSubview(tableView)
        
        // 제약 설정
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(46)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(12)
            
        }
    }
    
}
