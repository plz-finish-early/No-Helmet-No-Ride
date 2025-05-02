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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateUsageInfo(_:)),
            name: NSNotification.Name("UsageInfoUpdated"),
            object: nil
        )
    }
    
    
    func setupNavigation() {
        self.navigationItem.title = "이용 현황"
    }
    
    
    @objc
    func didTappedConfirmButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func updateUsageInfo(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let elapsedTime = userInfo["elapsedTime"] as? TimeInterval,
              let distance = userInfo["distance"] as? Int32,
              let amount = userInfo["amount"] as? Int32,
              let usingView = self.view as? UsageStatusUsingView else {
            return
        }

        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let distanceKM = Double(distance) / 1000.0

        usingView.timeDistanceValueLabel.text = "\(minutes) 분 \(String(format: "%02d", seconds)) 초\n\(String(format: "%.2f", distanceKM)) KM"
        usingView.feeValueLabel.text = "KRW \(amount) 원"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("UsageInfoUpdated"), object: nil)
    }
    
}

