//
//  UsageStatusUsingView.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit
import SnapKit

class UsageStatusUsingView: UIView {

    // MARK: - UI 요소

    private let kickboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon") 
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "이용중인 킥보드"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let kickboardIDLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 아이디"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()

    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let dateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "2025년 10월 28일"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()

    let timeDistanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 시간 및 거리"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    let timeDistanceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "000 분\n00 KM"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()

    let feeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이용 요금"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    let feeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "KRW 00000 원"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()

    let confirmButton = MainButton(title: "확인")

    // MARK: - 초기화

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func setupView() {
        backgroundColor = .white

        [kickboardImageView, statusLabel, kickboardIDLabel,
         dateTitleLabel, dateValueLabel,
         timeDistanceTitleLabel, timeDistanceValueLabel,
         feeTitleLabel, feeValueLabel,
         confirmButton].forEach { addSubview($0) }

        kickboardImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(kickboardImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }

        kickboardIDLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        dateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(kickboardIDLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        dateValueLabel.snp.makeConstraints { make in
            make.top.equalTo(dateTitleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        timeDistanceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateValueLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        timeDistanceValueLabel.snp.makeConstraints { make in
            make.top.equalTo(timeDistanceTitleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        feeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeDistanceValueLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        feeValueLabel.snp.makeConstraints { make in
            make.top.equalTo(feeTitleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            
        }
    }
    
}

// 킥보드 정보를 라벨에 뿌려주는 데이터 바인딩 함수

extension UsageStatusUsingView {
    func configure(with kickboard: KickboardData) {
        // 킥보드 ID
        self.kickboardIDLabel.text = kickboard.kickboardID ?? "알 수 없음"

        // 등록 날짜
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        if let date = kickboard.registrationDate {
            self.dateValueLabel.text = formatter.string(from: date)
        } else {
            self.dateValueLabel.text = "날짜 없음"
        }

        // 운행 시간 및 거리
        let minutes = Int(kickboard.totalUsageTime)
        let km = Double(kickboard.totalUsageDistance) / 1000.0
        self.timeDistanceValueLabel.text = "\(minutes) 분\n\(String(format: "%.2f", km)) KM"

        // 요금은 없으니 기본값
        self.feeValueLabel.text = "KRW 00000 원"
    }
}
