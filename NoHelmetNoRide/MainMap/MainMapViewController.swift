//
//  MainMapViewController.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/28/25.
//
import UIKit
import SnapKit

class MainMapViewController: BaseMapViewController {
    
    // MARK: - UI Components
    let bottomSheetView = CustomBottomSheetView()
    let ridingKickboardView = RidingKickboardView()
    let usingKickboardButton = UsingKickboardButton(title: "킥보드 이용하기")
    
    // MARK: - Layout Constraints
    var bottomSheetViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self  // 지도 이벤트 델리게이트 설정
        
        setupUI()
        setupConstraints()
        configureBottomSheet()
    }
    
    // MARK: - UI Configuration
    private func setupUI() {
        view.backgroundColor = .clear
        usingKickboardButton.addTarget(self, action: #selector(didTapUsingKickboardButton), for: .touchUpInside)
        
        ridingKickboardView.layer.borderColor = UIColor.black.cgColor
        ridingKickboardView.layer.borderWidth = 1
    }
    
    private func configureBottomSheet() {
        bottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 260 // 초기 위치: 화면 밖
        )
        bottomSheetView.delegate = self
        bottomSheetViewBottomConstraint?.isActive = true
        view.bringSubviewToFront(bottomSheetView)  // 뷰 계층 최상단으로
        
        bottomSheetView.delegate = self
    }
    //MARK: - Button Action
    
    @objc func didTapUsingKickboardButton() {
        showKickboardUseAlert()
    }
    
    func showKickboardUseAlert() {
        let alert = UIAlertController(
            title: "킥보드를 선택해 주세요.",
            message: "이용하실 킥보드를 먼저 선택 후\n킥보드 이용 버튼을 눌러주세요.",
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            print("확인")
        }
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Animation Methods
    private func showBottomSheet() {
        bottomSheetViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideBottomSheet() {
        guard bottomSheetViewBottomConstraint?.constant == 0 else { return }
        bottomSheetViewBottomConstraint?.constant = 260
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - AutoLayout Setup
    private func setupConstraints() {
        
        // 모든 UI 컴포넌트 추가
        [bottomSheetView, ridingKickboardView, usingKickboardButton].forEach {
            view.addSubview($0)
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(260)
            // bottom 제약은 configureBottomSheet에서 설정
        }
        
        usingKickboardButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        ridingKickboardView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(121)
            $0.height.equalTo(100)
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(bottomSheetView.snp.top).offset(-60).priority(.high)
            $0.bottom.greaterThanOrEqualTo(usingKickboardButton.snp.top).offset(-121).priority(.required)
        }
    }
}

// MARK: - Bottom Sheet Delegate
extension MainMapViewController: CustomBottomSheetViewDelegate {
    func didRequestShowUsageInvoiceView() {
        let usageInvoiceVC = UsageInvoiceViewController()
        usageInvoiceVC.modalPresentationStyle = .overFullScreen
        present(usageInvoiceVC, animated: true)
    }
    
    func didRequestShowSafetyInstructions() {
        let safetyVC = SafetyInstructionsViewController()
        safetyVC.modalPresentationStyle = .overFullScreen // 필요에 따라 스타일 지정
        present(safetyVC, animated: true)
    }
    
    func didRequestHide() {
        hideBottomSheet()
    }
    
    func didChangeRentalState(isRenting: Bool) {
        ridingKickboardView.ridingKickboardLabel.backgroundColor = isRenting ? .sub2 : .systemGray5
    }
    
    func presentInvoiceViewController(_ vc: UsageInvoiceViewController) {
          vc.modalPresentationStyle = .overFullScreen
          present(vc, animated: true)
      }
    
}

// MARK: - Map Interaction Delegate
extension MainMapViewController: MapViewDelegate {
    func didTapMarker(title: String, kickboardID: String, battery: Double) {
        showBottomSheet()
        
        bottomSheetView.configureKickboard(
                id: kickboardID,
                battery: Double(battery)
            )
    }
    
    func didTapMap() {
        hideBottomSheet()
    }
}
