//
//  UsageStatusViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/30/25.
//

import UIKit

enum Status {
    case using
    case empty
}

class UsageStatusViewController: UIViewController {
    
    let status: Status
    
    init(status: Status) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var statusView: UIView = {
        switch status {
        case .using:
            let statusView = UsageStatusUsingView()
            return statusView
        case .empty:
            let statusView = UsageStatusEmptyView()
            return statusView
        }
    }()
    
    override func loadView() {
        self.view = statusView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "이용 현황"
    }
    
}
