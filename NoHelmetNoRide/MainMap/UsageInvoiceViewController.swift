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
        
    }
}
