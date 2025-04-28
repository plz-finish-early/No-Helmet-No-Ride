//
//  ViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/25/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .main
        
        let loginVc = LoginViewController()
        let login = UINavigationController(rootViewController: loginVc)
        
        setup(login)
    }
    
    func setup(_ child: UIViewController) {
        addChild(child)
        self.view.addSubview(child.view)
        
        child.view.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        // 앤 뭐야
        child.didMove(toParent: self)
    }
}

