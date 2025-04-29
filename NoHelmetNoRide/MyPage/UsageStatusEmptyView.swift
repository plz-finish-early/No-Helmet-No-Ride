//
//  UsageStatusEmptyView.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit
import SnapKit

class UsageStatusEmptyView: UIView {

    // MARK: - UI 요소

    private let kickboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon") 
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let noUsageLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 이용중이 아닙니다."
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
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

        addSubview(kickboardImageView)
        addSubview(noUsageLabel)
        addSubview(confirmButton)

        kickboardImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        noUsageLabel.snp.makeConstraints { make in
            make.top.equalTo(kickboardImageView.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
}
