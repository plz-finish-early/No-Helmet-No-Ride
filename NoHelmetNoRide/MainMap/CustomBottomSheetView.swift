//
//  Untitled.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/28/25.
//

import UIKit

class CustomBottomSheetView: UIView {
    
    private var timer: Timer?
    private var startTime: Date?
    
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
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimeLabel),
            userInfo: nil,
            repeats: true
        )
        timer?.tolerance = 0.1
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        startTime = nil
    }
    
    @objc private func updateTimeLabel() {
        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        kickboardTimeLabel.text = String(format: "사용 시간: %02d분 %02d초", minutes, seconds)
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
            // 대여 시작
            isRenting.toggle()
            showSafetyInstructions()

            // 유저에 킥보드 연결
            let userID = LoginViewController.shared.loginUserID
            if let user = CoreDataManager.shared.fetchUserID(userID: userID) {
                CoreDataManager.shared.assignKickboardToUser(user: user, kickboardID: kickboardIDLabel.text ?? "")
            }

            // 킥보드 상태도 업데이트
            if let kickboard = CoreDataManager.shared.fetchKickboardData().first(where: {
                $0.kickboardID == kickboardIDLabel.text
            }) {
                CoreDataManager.shared.setKickboardInUse(kickboard: kickboard)
            }

        } else {
            // 반납
            isRenting.toggle()

            let usageTime = Date().timeIntervalSince(startTime ?? Date())
            let usageDistance: Int32 = 2600
            let usageAmount: Int32 = 1500

            let userID = LoginViewController.shared.loginUserID
            let kickboardID = kickboardIDLabel.text ?? "알 수 없음"

            CoreDataManager.shared.createUserUsageInfo(
                userID: userID,
                kickboardID: kickboardID,
                usageDate: Date(),
                usageTime: usageTime,
                usageDistance: usageDistance,
                usageAmount: usageAmount
            )

            // 반납된 킥보드 정보 업데이트 (상태, 거리, 시간)
            if let kickboard = CoreDataManager.shared.fetchKickboardData().first(where: {
                $0.kickboardID == kickboardID
            }) {
                CoreDataManager.shared.updateKickboardAfterUse(
                    kickboard: kickboard,
                    addedTime: usageTime,
                    addedDistance: usageDistance
                )
            }

            // 유저에서 킥보드 연결 해제
            if let user = CoreDataManager.shared.fetchUserID(userID: userID) {
                CoreDataManager.shared.unassignKickboardFromUser(user: user)
            }

            let usageList = CoreDataManager.shared.fetchUsageInfos(for: userID)
            guard let latestUsage = usageList.last else { return }

            let invoiceVC = UsageInvoiceViewController()
            invoiceVC.usageInfo = latestUsage
            delegate?.presentInvoiceViewController(invoiceVC)
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
        
        kickboardBatteryLabel.text = "배터리 잔량: nn%"
        kickboardBatteryLabel.font = .systemFont(ofSize: 14, weight: .thin)
        
        kickboardTimeLabel.isHidden = true
        kickboardTimeLabel.text = "사용 시간: 분"
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
    
    func configureKickboard(id: String, battery: Int) {
        kickboardIDLabel.text = id
        kickboardBatteryLabel.text = "배터리 잔량: \(battery)%"
    }
}

protocol CustomBottomSheetViewDelegate: AnyObject {
    func didRequestHide()
    func didChangeRentalState(isRenting: Bool)
    func didRequestShowSafetyInstructions()
    func didRequestShowUsageInvoiceView()
    func presentInvoiceViewController(_ vc: UsageInvoiceViewController)
}
