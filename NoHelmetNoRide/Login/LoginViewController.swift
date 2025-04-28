//
//  LoginViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true // 네비게이션 바 숨기기
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

