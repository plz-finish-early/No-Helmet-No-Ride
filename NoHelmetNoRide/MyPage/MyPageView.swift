//
//  MyPageView.swift
//  NoHelmetNoRide
//
//  Created by 전원식 on 4/28/25.
//

import UIKit
import SnapKit

class MyPageView: UIView {

    // MARK: - UI 요소


    public let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이정진레모니 님"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 원본 (원식님)
//    private let historyStack = MyPageView.makeRowStack(title: "이용 내역")
//    private let statusStack = MyPageView.makeRowStack(title: "이용 현황")
//    private let kickboardStack = MyPageView.makeRowStack(title: "등록한 킥보드")
    
    // 새로 버튼 구현
    private let historyLabel = UILabel() // 이용 내역
    private let historyImageView = UIImageView()
    let historyStack = UIStackView()
    private let statusLabel = UILabel() // 이용 현황
    private let statusImageView = UIImageView()
    let statusStack = UIStackView()
    private let kickboardLabel = UILabel() // 등록한 킥보드
    private let kickboardImageView = UIImageView()
    let kickboardStack = UIStackView()
    

    let logoutButton = MainButton(title: "로그아웃")

    
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


        logoutButton.backgroundColor = .sub2


        [nameLabel, historyStack, statusStack, kickboardStack, logoutButton].forEach {
            addSubview($0)
        }
        
        // 기존 내용
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        // 새로 추가
        historyStack.axis = .horizontal
        historyStack.alignment = .center
        historyStack.distribution = .equalSpacing
        
        
        historyLabel.text = "이용 내역"
        historyLabel.textColor = .font
        historyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        historyStack.addArrangedSubview(historyLabel)
        
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        historyImageView.image = image
        historyImageView.tintColor = .lightGray
        
        historyStack.addArrangedSubview(historyImageView)
        
        historyStack.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
        
        // 현황
        statusStack.axis = .horizontal
        statusStack.alignment = .center
        statusStack.distribution = .equalSpacing
        
        
        statusLabel.text = "이용 현황"
        statusLabel.textColor = .font
        statusLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        statusStack.addArrangedSubview(statusLabel)
        
        statusImageView.image = image
        statusImageView.tintColor = .lightGray
        
        statusStack.addArrangedSubview(statusImageView)
        
        statusStack.snp.makeConstraints { make in
            make.top.equalTo(historyStack.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
        
        // 킥보드
        kickboardStack.axis = .horizontal
        kickboardStack.alignment = .center
        kickboardStack.distribution = .equalSpacing
        
        kickboardLabel.text = "등록한 킥보드"
        kickboardLabel.textColor = .font
        kickboardLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        kickboardStack.addArrangedSubview(kickboardLabel)
        
        kickboardImageView.image = image
        kickboardImageView.tintColor = .lightGray
        
        kickboardStack.addArrangedSubview(kickboardImageView)
        
        kickboardStack.snp.makeConstraints { make in
            make.top.equalTo(statusStack.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
        
        

        //기존 내용
//        historyStack.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(50)
//            make.leading.trailing.equalToSuperview().inset(32)
//            make.height.equalTo(40)
//        }

//        statusStack.snp.makeConstraints { make in
//            make.top.equalTo(historyStack.snp.bottom).offset(40)
//            make.leading.trailing.equalToSuperview().inset(32)
//            make.height.equalTo(40)
//        }

//        kickboardStack.snp.makeConstraints { make in
//            make.top.equalTo(statusStack.snp.bottom).offset(40)
//            make.leading.trailing.equalToSuperview().inset(32)
//            make.height.equalTo(40)
//        }

        logoutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }

    // MARK: - 버튼 두 개가 들어간 가로 스택뷰 만들기
    
    private static func makeRowStack(title: String) -> UIStackView {
        
        let titleButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
            button.contentHorizontalAlignment = .leading
            return button
        }()


        let chevronButton: UIButton = {
            let button = UIButton(type: .system)
            let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
            let image = UIImage(systemName: "chevron.right", withConfiguration: config)
            button.setImage(image, for: .normal)
            button.tintColor = .lightGray
            button.contentHorizontalAlignment = .trailing
            return button
        }()

        
        let stack = UIStackView(arrangedSubviews: [titleButton, chevronButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }
}
