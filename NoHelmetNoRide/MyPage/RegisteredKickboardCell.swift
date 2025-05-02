//
//  RegisteredKickboardCell.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit
import SnapKit

class RegisteredKickboardCell: UITableViewCell {
    //MARK: - Property
    let logoImageView = UIImageView()
    let kickBoardIdLabel = UILabel()
    let kickBoardIdDataLabel = UILabel() // 실제 데이터가 들어갈 라벨
    let registeredDateLabel = UILabel()
    let registeredDateDataLabel = UILabel() // 실제 데이터가 들어갈 라벨
    let totalDriveLabel = UILabel()
    let totalDriveDataLabel = UILabel() // 실제 데이터가 들어갈 라벨
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    // cell 레이아웃 설정
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 20 // 둥굴기 설정
        contentView.layer.borderWidth = 1 // 테두리 설정
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 4, bottom: 24, right: 4)) // 셀 여백 설정
    }
    
    private func setupCell() {
        // 로고 설정
        logoImageView.image = .icon
        
        addSubview(logoImageView)
        
        // 제약 설정
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.contentView).offset(16)
            $0.leading.equalTo(self.contentView).offset(19)
            $0.width.height.equalTo(18)
        }
        
        // 킥보드 ID 설정
        kickBoardIdLabel.text = "킥보드 ID:"
        kickBoardIdLabel.textColor = .font
        kickBoardIdLabel.textAlignment = .left
        kickBoardIdLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        addSubview(kickBoardIdLabel)
        
        // 제약 설정
        kickBoardIdLabel.snp.makeConstraints {
            $0.top.equalTo(self.contentView).offset(14)
            $0.leading.equalTo(self.logoImageView.snp.trailing).offset(8)
            $0.height.equalTo(22)
        }
        
        // 킥보드 ID 데이터 설정
        kickBoardIdDataLabel.text = "test1234" // 테스트 용 값
        kickBoardIdDataLabel.textColor = .font
        kickBoardIdDataLabel.textAlignment = .left
        kickBoardIdDataLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        addSubview(kickBoardIdDataLabel)
        
        // 제약 설정
        kickBoardIdDataLabel.snp.makeConstraints {
            $0.top.equalTo(kickBoardIdLabel.snp.top)
            $0.leading.equalTo(kickBoardIdLabel.snp.trailing).offset(2)
            $0.height.equalTo(22)
        }
        
        // 등록날짜
        registeredDateLabel.text = "등록날짜:"
        registeredDateLabel.textColor = .font
        registeredDateLabel.textAlignment = .left
        registeredDateLabel.font = .systemFont(ofSize: 12)
        
        addSubview(registeredDateLabel)
        
        // 제약 설정
        registeredDateLabel.snp.makeConstraints {
            $0.top.equalTo(kickBoardIdLabel.snp.bottom).offset(8)
            $0.leading.equalTo(kickBoardIdLabel.snp.leading)
            $0.height.equalTo(22)
        }
        
        // 등록날짜 데이터 설정
        registeredDateDataLabel.text = "25.04.27" // 테스트 용 값
        registeredDateDataLabel.textColor = .font
        registeredDateDataLabel.textAlignment = .left
        registeredDateDataLabel.font = .systemFont(ofSize: 12)
        
        addSubview(registeredDateDataLabel)
        
        // 제약 설정
        registeredDateDataLabel.snp.makeConstraints {
            $0.top.equalTo(registeredDateLabel.snp.top)
            $0.leading.equalTo(registeredDateLabel.snp.trailing).offset(2)
            $0.height.equalTo(22)
        }
        
        // 총 운행
        totalDriveLabel.text = "총 운행:"
        totalDriveLabel.textColor = .font
        totalDriveLabel.textAlignment = .left
        totalDriveLabel.font = .systemFont(ofSize: 12)
        
        addSubview(totalDriveLabel)
        
        // 제약 설정
        totalDriveLabel.snp.makeConstraints {
            $0.top.equalTo(registeredDateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(kickBoardIdLabel.snp.leading)
            $0.height.equalTo(22)
        }
        
        // 총 운행 데이터 설정
        totalDriveDataLabel.text = "00분 00Km" // 테스트 용 값
        totalDriveDataLabel.textColor = .font
        totalDriveDataLabel.textAlignment = .left
        totalDriveDataLabel.font = .systemFont(ofSize: 12)
        
        addSubview(totalDriveDataLabel)
        
        // 제약 설정
        totalDriveDataLabel.snp.makeConstraints {
            $0.top.equalTo(totalDriveLabel.snp.top)
            $0.leading.equalTo(totalDriveLabel.snp.trailing).offset(2)
            $0.height.equalTo(22)
        }
    }
    
    // 저장된 데이터로 나타내주는 함수
    func configure(with kickboard: KickboardData) {
        kickBoardIdDataLabel.text = kickboard.kickboardID ?? "알 수 없음"

        if let date = kickboard.registrationDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yy.MM.dd"
            registeredDateDataLabel.text = formatter.string(from: date)
        } else {
            registeredDateDataLabel.text = "날짜 없음"
        }

        let usageMinutes = Int(kickboard.totalUsageTime)
        let usageKm = Double(kickboard.totalUsageDistance) / 1000.0
        totalDriveDataLabel.text = "\(usageMinutes)분 \(String(format: "%.1f", usageKm))Km"
    }
}
