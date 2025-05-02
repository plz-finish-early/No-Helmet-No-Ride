//
//  SafetyInstructionViewController.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 5/1/25.
//

import UIKit

class SafetyInstructionsViewController: UIViewController {
    
    let safetyInstructions = SafetyInstructions()
    
    override func loadView() {
        self.view = safetyInstructions
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safetyInstructions.delegate = self
        
    }
}

// MARK: - SafetyInstructionsViewDelegate
extension SafetyInstructionsViewController: SafetyInstructionsViewDelegate {
    func didTapConfirm() {
        dismiss(animated: true, completion: nil)
    }
}
