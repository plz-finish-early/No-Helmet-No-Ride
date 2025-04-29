//
//  KickboardRegistrationWithMap.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/28/25.
//
import UIKit

class KickboardRegistrationWithMap: UIViewController {
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "핀을 움직여 위치를 선택하세요"
        label.textColor = .font
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = .sub3
        label.layer.cornerRadius = 23
        label.layer.masksToBounds = true
        return label
    }()
    
    let mapview: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        return uiView
    }()
    
    lazy private var nextButton: UIButton = {
        let button = MainButton(title: "다음")
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        [
            mapview,
            topLabel,
            nextButton
        ].forEach{ view.addSubview($0) }
        
        topLabel.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.equalToSuperview().offset(45)
            $0.horizontalEdges.equalToSuperview().inset(88)
        }
        
        mapview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func nextButtonTapped() {
        print("nextButtonTapped")
    }
}
