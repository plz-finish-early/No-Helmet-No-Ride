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
    var usageInfo: UserUsageInfo?
    
    
    override func loadView() {
        self.view = usageInvoiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usageInvoiceView.delegate = self
        
        // 실제 CoreData 값으로 뷰 구성
           if let info = usageInfo {
               usageInvoiceView.configure(with: info)
           }

    }
}

// MARK: - SafetyInstructionsViewDelegate
extension UsageInvoiceViewController: UsageInvoiceViewDelegate {
    func didTapConfirm() {
        dismiss(animated: true, completion: nil)
    }
}
