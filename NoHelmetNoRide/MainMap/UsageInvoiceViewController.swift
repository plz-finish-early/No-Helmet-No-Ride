//
//  UseageInvoiceViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit

class UsageInvoiceViewController: UIViewController {
    
    let usageInvoiceView = UsageInvoiceView()
    
    
    override func loadView() {
        self.view = usageInvoiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usageInvoiceView.delegate = self
    }
    
    func updateData(usageInfo: UserUsageInfo) {
        usageInvoiceView.updateUI(usageInfo: usageInfo)
    }
}

// MARK: - SafetyInstructionsViewDelegate
extension UsageInvoiceViewController: UsageInvoiceViewDelegate {
    func didTapConfirm() {
        dismiss(animated: true, completion: nil)
    }
}
