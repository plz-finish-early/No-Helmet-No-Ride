//
//  UsageInvoiceView.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/28/25.
//

import Foundation
import UIKit
import SnapKit

class UsageInvoiceView: UIView {
    // MARK: - Property
    let titleLabel = UILabel() // 최상단 로그인 타이틀
    let usedKickboardLabel = UILabel() // 이용한 킥보드
    let kickboardIdLabel = UILabel() // 킥보드 아이디 데이터 들어가는 라벨
    let useDateLabel = UILabel() // 이용 날짜
    let useDateDataLabel = UILabel() // 날짜 데이터
    let drivingTimeDistanceLabel = UILabel() // 운행 시간 및 거리
    let drivingTimeData = UILabel() // 운행시간 데이터
    let drivingDistanceDataLabel = UILabel() // 운행 거리 데이터
    let chargeLabel = UILabel() // 이용 요금
    let chargeDataLabel = UILabel() // 이용 요금 데이터
    let iconImageView = UIImageView() // 아이콘을 보여주는 ImageView
    // 찬호박님 버튼, 로그인 버튼
    let mainButton = MainButton(title: "확인") // 로그인 버튼
    
    weak var delegate: UsageInvoiceViewDelegate?

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func setupView() {
        self.backgroundColor = .white
        
        // 타이틀 속성 설정
        self.titleLabel.text = "이용 내역"
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 32)
        self.titleLabel.textAlignment = .left
        
        self.addSubview(self.titleLabel)
        
        // 제약 설정
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        
        // usedKickboardLabel 설정
        self.usedKickboardLabel.text = "이용한 킥보드"
        self.usedKickboardLabel.textColor = .black
        self.usedKickboardLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.usedKickboardLabel.textAlignment = .left
        
        self.addSubview(self.usedKickboardLabel)
        
        // 제약 설정
        self.usedKickboardLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(44)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(48)
            $0.height.equalTo(22)
        }
        
        // kickboardIdLabel 설정
        self.kickboardIdLabel.text = "testKickBoard0192"
        self.kickboardIdLabel.textColor = .black
        self.kickboardIdLabel.font = .systemFont(ofSize: 16)
        self.kickboardIdLabel.textAlignment = .left
        
        self.addSubview(self.kickboardIdLabel)
        
        // 제약 설정
        self.kickboardIdLabel.snp.makeConstraints {
            $0.top.equalTo(usedKickboardLabel.snp.bottom).offset(14)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(52)
            $0.height.equalTo(22)
        }
        
        
        // useDateLabel 설정
        self.useDateLabel.text = "이용 날짜"
        self.useDateLabel.textColor = .black
        self.useDateLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.useDateLabel.textAlignment = .left
        
        self.addSubview(self.useDateLabel)
        
        // 제약 설정
        self.useDateLabel.snp.makeConstraints {
            $0.top.equalTo(kickboardIdLabel.snp.bottom).offset(36)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(48)
            $0.height.equalTo(22)
        }
        
        // useDateDataLabel 설정
        self.useDateDataLabel.text = "2025년 10월 29일" // 년, 월, 일 데이터
        self.useDateDataLabel.textColor = .black
        self.useDateDataLabel.font = .systemFont(ofSize: 16)
        self.useDateDataLabel.textAlignment = .left
        
        self.addSubview(self.useDateDataLabel)
        
        // 제약 설정
        self.useDateDataLabel.snp.makeConstraints {
            $0.top.equalTo(useDateLabel.snp.bottom).offset(14)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(52)
            $0.height.equalTo(22)
        }
        
        // drivingTimeDistanceLabel 설정
        self.drivingTimeDistanceLabel.text = "운행 시간 및 거리"
        self.drivingTimeDistanceLabel.textColor = .black
        self.drivingTimeDistanceLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.drivingTimeDistanceLabel.textAlignment = .left
        
        self.addSubview(self.drivingTimeDistanceLabel)
        
        // 제약 설정
        self.drivingTimeDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(useDateDataLabel.snp.bottom).offset(36)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(48)
            $0.height.equalTo(22)
        }
        
        // drivingTimeData 설정
        self.drivingTimeData.text = "38분" // 분 데이터
        self.drivingTimeData.textColor = .black
        self.drivingTimeData.font = .systemFont(ofSize: 16)
        self.drivingTimeData.textAlignment = .left
        
        self.addSubview(self.drivingTimeData)
        
        // 제약 설정
        self.drivingTimeData.snp.makeConstraints {
            $0.top.equalTo(drivingTimeDistanceLabel.snp.bottom).offset(14)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(52)
            $0.height.equalTo(22)
        }
        
        // drivingDistanceDataLabel 설정
        self.drivingDistanceDataLabel.text = "3.8KM" // KM 데이터 / 더블 타입?
        self.drivingDistanceDataLabel.textColor = .black
        self.drivingDistanceDataLabel.font = .systemFont(ofSize: 16)
        self.drivingDistanceDataLabel.textAlignment = .left
        
        self.addSubview(self.drivingDistanceDataLabel)
        
        // 제약 설정
        self.drivingDistanceDataLabel.snp.makeConstraints {
            $0.top.equalTo(drivingTimeData.snp.bottom).offset(6)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(52)
            $0.height.equalTo(22)
        }
        
        // chargeLabel 설정
        self.chargeLabel.text = "이용 요금"
        self.chargeLabel.textColor = .black
        self.chargeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.chargeLabel.textAlignment = .left
        
        self.addSubview(self.chargeLabel)
        
        // 제약 설정
        self.chargeLabel.snp.makeConstraints {
            $0.top.equalTo(drivingDistanceDataLabel.snp.bottom).offset(36)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(48)
            $0.height.equalTo(22)
        }
        
        // chargeDataLabel 설정
        self.chargeDataLabel.text = "KRW 38000 원" // 가격 데이터
        self.chargeDataLabel.textColor = .black
        self.chargeDataLabel.font = .systemFont(ofSize: 16)
        self.chargeDataLabel.textAlignment = .left
        
        self.addSubview(self.chargeDataLabel)
        
        // 제약 설정
        self.chargeDataLabel.snp.makeConstraints {
            $0.top.equalTo(chargeLabel.snp.bottom).offset(14)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(52)
            $0.height.equalTo(22)
        }

        // 확인 버튼 추가
        self.addSubview(mainButton)
        mainButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        // 제약 설정
        self.mainButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(12)
        }
        
        // 아이콘 설정
        self.iconImageView.image = .imageIcon
        self.iconImageView.contentMode = .scaleAspectFill
        
        self.addSubview(self.iconImageView)
        
        // 제약 설정
        self.iconImageView.snp.makeConstraints {
            $0.bottom.equalTo(mainButton.snp.top).offset(-36)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(36)
        }
    }
    
    @objc private func confirmButtonTapped() {
        print("confirmButtonTapped")
        delegate?.didTapConfirm()
    }
    
    // 저장된 데이터로 나타내주는 함수
    func configure(with info: UserUsageInfo) {
        kickboardIdLabel.text = info.kickboardID ?? "알 수 없음"

        if let date = info.usageDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            useDateDataLabel.text = formatter.string(from: date)
        } else {
            useDateDataLabel.text = "날짜 없음"
        }

        drivingTimeData.text = "\(Int(info.usageTime))분"
        let km = Double(info.usageDistance) / 1000.0
        drivingDistanceDataLabel.text = String(format: "%.1fKM", km)
        chargeDataLabel.text = "KRW \(info.usageAmount) 원"
    }
}

protocol UsageInvoiceViewDelegate: AnyObject {
    func didTapConfirm()
}
