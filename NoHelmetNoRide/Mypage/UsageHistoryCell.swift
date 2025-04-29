//
//  UsageHistoryCell.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit
import SnapKit

class UsageHistoryCell: UITableViewCell {
    // MARK: - Property
    let logoImageView = UIImageView()
    let kickboardIdLabel = UILabel()
    let dateLabel = UILabel()
    let drivingInfoLabel = UILabel()
    let priceLabel = UILabel()

    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 4, bottom: 24, right: 4))
    }

    // MARK: - Method
    private func setupCell() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(kickboardIdLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(drivingInfoLabel)
        contentView.addSubview(priceLabel)
        
        logoImageView.image = .icon
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(19)
            $0.width.height.equalTo(18)
            $0.centerY.equalTo(kickboardIdLabel.snp.centerY)
        }
        
        kickboardIdLabel.text = "킥보드 ID:"
        kickboardIdLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        kickboardIdLabel.textColor = .font
        kickboardIdLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(8)
        }
        
        dateLabel.text = "날짜: 25.04.27"
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .font
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(kickboardIdLabel.snp.bottom).offset(8)
            $0.leading.equalTo(kickboardIdLabel)
        }
        
        drivingInfoLabel.text = "운행: 00분, 00KM"
        drivingInfoLabel.font = .systemFont(ofSize: 12)
        drivingInfoLabel.textColor = .font
        drivingInfoLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(kickboardIdLabel)
        }
        
        priceLabel.text = "요금: 00000원"
        priceLabel.font = .systemFont(ofSize: 12)
        priceLabel.textColor = .font
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(drivingInfoLabel.snp.bottom).offset(4)
            $0.leading.equalTo(kickboardIdLabel)
        }
    }
}
