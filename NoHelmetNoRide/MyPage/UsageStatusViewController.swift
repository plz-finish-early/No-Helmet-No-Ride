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
    var kickboard: KickboardData?
    
    init(status: Status) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var statusView: UIView = {
        switch self.status {
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
        addButtonAction()
        
        if status == .using,
              let usingView = statusView as? UsageStatusUsingView,
              let kickboard = kickboard {
               usingView.configure(with: kickboard)
           }
    }
    
    func setupNavigation() {
        self.navigationItem.title = "이용 현황"
    }
    
    func addButtonAction() {
        if let usingView = statusView as? UsageStatusUsingView {
            usingView.confirmButton.addTarget(self, action: #selector(didTappedConfirmButton), for: .touchUpInside)
        }
    }
    
    @objc
    func didTappedConfirmButton() {
        navigationController?.popViewController(animated: true)
    }
}
