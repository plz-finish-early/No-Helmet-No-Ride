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
    
    override func loadView() {
        let currentUserID = LoginViewController.shared.loginUserID
        if let kickboard = CoreDataManager.shared.fetchInUseKickboards(for: currentUserID) {
            let usingView = UsageStatusUsingView()
            usingView.configure(with: kickboard)
            usingView.confirmButton.addTarget(self, action: #selector(didTappedConfirmButton), for: .touchUpInside)
            self.view = usingView
        } else {
            let emptyView = UsageStatusEmptyView()
            emptyView.confirmButton.addTarget(self, action: #selector(didTappedConfirmButton), for: .touchUpInside)
            self.view = emptyView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func setupNavigation() {
        self.navigationItem.title = "이용 현황"
    }
    
    
    @objc
    func didTappedConfirmButton() {
        navigationController?.popViewController(animated: true)
    }
}
