//
//  Untitled.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/28/25.
//

import UIKit

class CustomBottomSheetView: UIView {
    
    weak var delegate: CustomBottomSheetViewDelegate?
    
    private var isRenting: Bool = false {
        didSet {
            updateUIForRentalState()
        }
    }
    
    let kickboardIDLabel = UILabel()
    let kickboardRentButton = MainButton(title: "킥보드 이용하기")
    let kickboardLabel = UILabel()
    let kickboardBatteryLabel = UILabel()
    let kickboardTimeLabel = UILabel()
    
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
    
    @objc func didTapClose() {
        // 뷰 컨트롤러에 닫기 요청 전달
        delegate?.didRequestHide()
    }
    
    private func updateUIForRentalState() {
        kickboardTimeLabel.isHidden = !isRenting
        kickboardRentButton.setTitle(isRenting ? "킥보드 반납하기" : "킥보드 이용하기", for: .normal)
        delegate?.didChangeRentalState(isRenting: isRenting)
    }
    
    @objc private func didTapRentButton() {
        isRenting.toggle()
    }
    
    private func setupUI() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        
        kickboardRentButton.addTarget(self, action: #selector(didTapRentButton), for: .touchUpInside)
        
        kickboardIDLabel.text = "킥보드 ID"
        kickboardIDLabel.font = .systemFont(ofSize: 24, weight: .thin)
        
        kickboardLabel.text = "전동킥보드"
        kickboardLabel.font = .systemFont(ofSize: 14, weight: .thin)
        
        kickboardBatteryLabel.text = "배터리 잔량: nn%"
        kickboardBatteryLabel.font = .systemFont(ofSize: 14, weight: .thin)
        
        kickboardTimeLabel.isHidden = true
        kickboardTimeLabel.text = "사용 시간: nn분"
        kickboardTimeLabel.font = .systemFont(ofSize: 14, weight: .thin)
    }
    
    private func setupConstraints() {
        [
            kickboardIDLabel,
            kickboardRentButton,
            kickboardLabel,
            kickboardTimeLabel,
            kickboardBatteryLabel
            
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            kickboardRentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            kickboardRentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            kickboardRentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
            
            kickboardIDLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            kickboardIDLabel.bottomAnchor.constraint(equalTo: kickboardRentButton.topAnchor, constant: -40),
            
            kickboardLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            kickboardLabel.bottomAnchor.constraint(equalTo: kickboardIDLabel.topAnchor, constant: -26),
            
            kickboardBatteryLabel.bottomAnchor.constraint(equalTo: kickboardRentButton.topAnchor, constant: -40),
            kickboardBatteryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            kickboardTimeLabel.bottomAnchor.constraint(equalTo: kickboardBatteryLabel.topAnchor, constant: -8),
            kickboardTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
    }
}

protocol CustomBottomSheetViewDelegate: AnyObject {
    func didRequestHide()
    func didChangeRentalState(isRenting: Bool)
}
