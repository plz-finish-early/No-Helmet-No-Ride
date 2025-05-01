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
    var customSegmentedControl = UISegmentedControl()
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
    }
    
    private func configureBottomSheet() {
        bottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 260 // 초기 위치: 화면 밖
        )
        bottomSheetView.delegate = self
        bottomSheetViewBottomConstraint?.isActive = true
        view.bringSubviewToFront(bottomSheetView)  // 뷰 계층 최상단으로
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
        super.setupMapView()  // 부모 클래스의 지도 뷰 설정 호출
        
        // 모든 UI 컴포넌트 추가
        [customSegmentedControl, bottomSheetView, ridingKickboardView, usingKickboardButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        // 레이아웃 제약 조건
        NSLayoutConstraint.activate([
            // 세그먼트 컨트롤
            customSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            customSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            customSegmentedControl.heightAnchor.constraint(equalToConstant: 26),
            
            // 바텀 시트
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 260),
            
            // 킥보드 안내 뷰
            ridingKickboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // 이용하기 버튼
            usingKickboardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            usingKickboardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usingKickboardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // 동적 제약 조건 (우선순위 설정)
        let dynamicConstraints = [
            ridingKickboardView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: -60),
            ridingKickboardView.bottomAnchor.constraint(greaterThanOrEqualTo: usingKickboardButton.topAnchor, constant: -121)
        ]
        dynamicConstraints[0].priority = .defaultHigh  // 기본 우선순위
        dynamicConstraints[1].priority = .required     // 필수 조건
        NSLayoutConstraint.activate(dynamicConstraints)
        
        // 고정 크기 제약
        ridingKickboardView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ridingKickboardView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}

// MARK: - Bottom Sheet Delegate
extension MainMapViewController: CustomBottomSheetViewDelegate {
    func didRequestHide() {
        hideBottomSheet()
    }
}

// MARK: - Map Interaction Delegate
extension MainMapViewController: MapViewDelegate {
    func didTapMarker(title: String, address: String) {
        showBottomSheet()
    }
    
    func didTapMap() {
        hideBottomSheet()
    }
}
