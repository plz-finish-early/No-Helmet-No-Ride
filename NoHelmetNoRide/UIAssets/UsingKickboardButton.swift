//
//  UsingKickboardButton.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/29/25.
//

import UIKit
import SnapKit

class UsingKickboardButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, font: UIFont, color: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.titleLabel?.font = font
        setConfig() //init시 setConfig 메서드 호출
    }

    convenience init(title: String) {
        self.init(title: title,
                  font: .systemFont(ofSize: 24, weight: .thin),
                  color: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 인스턴스가 생성될때 초기 설정 값 설정 메서드
    func setConfig() {
        self.setTitleColor(.font, for: .normal)
        self.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
}


