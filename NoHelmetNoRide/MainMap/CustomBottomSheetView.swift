//
//  Untitled.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/28/25.
//

import UIKit

class CustomBottomSheetView: UIView {
    
    private var startTime: Date?
    private var timer: Timer?
    private var distance: Double = 0
    private var battery: Int = 100 // 예시: 100%에서 시작
    private let kickboardSpeed: Double = 3 // m/s (10km/h)
    
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
    
    func startTimer() {
            startTime = Date()
            distance = 0
            battery = 100
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateInfo),
                                         userInfo: nil,
                                         repeats: true)
        }

        // 타이머 중지
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }

        @objc private func updateInfo() {
            guard let startTime = startTime else { return }
            let elapsedTime = Date().timeIntervalSince(startTime)
            let minutes = Int(elapsedTime) / 60
            let seconds = Int(elapsedTime) % 60

            // 거리 계산 (10km/h = 3/s)
            distance = elapsedTime * kickboardSpeed
            //kickboardDistanceLabel.text = String(format: "이동 거리: %.1f m", distance)

            // 배터리 잔량 예시 (10초에 1% 감소, 0% 이하로 떨어지지 않게)
            battery = max(0, 100 - Int(elapsedTime/10))
            kickboardBatteryLabel.text = "배터리 잔량: \(battery)%"

            // 시간 표시
            kickboardTimeLabel.text = String(format: "사용 시간: %02d분 %02d초", minutes, seconds)

            // 오늘 날짜 표시
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy년 MM월 dd일"
            let todayString = formatter.string(from: Date())
            //kickboardDateLabel.text = "오늘 날짜: \(todayString)"
        }
    
    private func updateUIForRentalState() {
        kickboardTimeLabel.isHidden = !isRenting
        kickboardRentButton.setTitle(isRenting ? "킥보드 반납하기" : "킥보드 이용하기", for: .normal)
        delegate?.didChangeRentalState(isRenting: isRenting)
        
        if isRenting {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    @objc private func didTapRentButton() {
        if isRenting == false {
            isRenting.toggle()
            showSafetyInstructions()
        } else {
            isRenting.toggle()
            showUsageInvoiceView()
        }
    }
    
    @objc func showSafetyInstructions() {
        delegate?.didRequestShowSafetyInstructions()
    }
    
    @objc func showUsageInvoiceView() {
        delegate?.didRequestShowUsageInvoiceView()
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
        
        kickboardBatteryLabel.text = "배터리 잔량: \(battery)%"
        kickboardBatteryLabel.font = .systemFont(ofSize: 14, weight: .thin)
        
        kickboardTimeLabel.isHidden = true
        //kickboardTimeLabel.text = "사용 시간: 분"
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
            addSubview($0)
        }
        
        kickboardRentButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(36)
        }
        
        kickboardIDLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.bottom.equalTo(kickboardRentButton.snp.top).offset(-40)
        }
        
        kickboardLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.bottom.equalTo(kickboardIDLabel.snp.top).offset(-26)
        }
        
        kickboardBatteryLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(kickboardRentButton.snp.top).offset(-40)
        }
        
        kickboardTimeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(kickboardBatteryLabel.snp.top).offset(-8)
        }
    }
}

protocol CustomBottomSheetViewDelegate: AnyObject {
    func didRequestHide()
    func didChangeRentalState(isRenting: Bool)
    func didRequestShowSafetyInstructions()
    func didRequestShowUsageInvoiceView()
}
