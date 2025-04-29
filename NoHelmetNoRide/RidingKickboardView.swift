//
//  KickboardViewControll.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/28/25.
//

import UIKit
import SnapKit

class RidingKickboardView: UIView {
    
    let ridingKickboardLabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        ridingKickboardLabel.backgroundColor = .systemGray5
        ridingKickboardLabel.text = "킥보드 탑승중"
        ridingKickboardLabel.font = .systemFont(ofSize: 13, weight: .regular)
        ridingKickboardLabel.layer.cornerRadius = 25
        ridingKickboardLabel.clipsToBounds = true
        ridingKickboardLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        [
            ridingKickboardLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            ridingKickboardLabel.widthAnchor.constraint(equalToConstant: 104),
            ridingKickboardLabel.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
