//
//  MainViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/30/25.
//

import UIKit

class MainViewController: UIViewController {
    let customSegmentedControl = UISegmentedControl(items: ["지도", "킥보드 등록", "마이페이지"])
    
    let mainMapView = MainMapViewController()
    let kickboard = KickboardRegistrationWithMap()
    let myPage = MyPageViewController()
    
    var currentViewController: UIViewController?
    
    let networkService = NetworkService()
    let searchBar = AddressSearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        setupSegmentedControl()
        switchToView(index: 0) // 초기에는 지도 뷰
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(false) //서치바 이외에 선택시 편집 종료
    }
    
    func setupSegmentedControl() {
        
        customSegmentedControl.selectedSegmentIndex = 0
        
        // 세그먼트 변경 시 호출될 메서드 등록
        customSegmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        // 일반 상태에서의 텍스트 스타일 설정 (회색 톤, 레귤러)
        customSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.font.withAlphaComponent(0.7),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ], for: .normal)
        
        // 선택된 상태에서의 텍스트 스타일 설정 (기본 폰트 컬러, 세미볼드)
        customSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.font,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ], for: .selected)
        
        //segmentedControll 백그라운드 및 셀렉터값 모두 없애기
        customSegmentedControl.selectedSegmentTintColor = .clear
        customSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        customSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        view.addSubview(customSegmentedControl)
        customSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // 제약 조건
        NSLayoutConstraint.activate([
            customSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            customSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            customSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customSegmentedControl.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switchToView(index: sender.selectedSegmentIndex)
    }
    
    func switchToView(index: Int) {
        // 이전 뷰 컨트롤러를 화면에서 제거
        /*
         내부적으로 뷰 컨트롤러 라이프사이클에 따라
         willMove(toParent:) → 제거 → didMove(toParent:) 순으로 호출하는 게 정석적인 구조
         */
        currentViewController?.willMove(toParent: nil) // 자식 뷰컨에게 곧 부모 뷰 컨트롤러에서 제거될 거야 라고 알려줌
        currentViewController?.view.removeFromSuperview() // 화면에서 뷰 제거
        currentViewController?.removeFromParent() // 부모 컨트롤러에서 자식 컨트롤러 제거
        
        // 선택된 인덱스에 따라 새로운 뷰 컨트롤러 선택
        let selectedVC: UIViewController
        switch index {
        case 0:
            selectedVC = mainMapView
            mainMapView.updateData()
        case 1:
            selectedVC = kickboard
            kickboard.updateData()
        case 2:
            selectedVC = myPage
        default:
            return
        }
        
        if selectedVC == mainMapView {
            selectedVC.view.addSubview(searchBar)
            
            searchBar.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(50)
                $0.horizontalEdges.equalToSuperview().inset(12)
                $0.top.equalToSuperview().offset(20)
            }
        } else {
            searchBar.removeFromSuperview()
        }
        
        // 새로운 뷰 컨트롤러를 자식으로 추가
        addChild(selectedVC)
        view.addSubview(selectedVC.view)
        selectedVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        // 선택된 뷰의 Auto Layout 제약 설정 (세그먼트 아래부터 전체 채우기)
        NSLayoutConstraint.activate([
            selectedVC.view.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 10),
            selectedVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectedVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectedVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 부모 컨트롤러에 추가 완료 알림
        selectedVC.didMove(toParent: self)
        
        // 현재 뷰 컨트롤러로 상태 업데이트
        currentViewController = selectedVC
    }
}


extension MainViewController: AddressSearchBarDelegate {
    func getCooredinates(address: String, coodinates: (Double, Double)) {
        print("버튼 클릭됨")
        Task {
            do {
                let result = try await networkService.serializedAddressToCoordinates(address: address)
                guard let lat = Double(result.addresses[0].y) else {
                    throw CustomMapError.failedConverStringToDouble
                }
                guard let lng = Double(result.addresses[0].x) else {
                    throw CustomMapError.failedConverStringToDouble
                }
                print("네이버 api 주소로 좌표 가져오기 성공")
                mainMapView.moveCameraToselectedAddress(lat: lat, lng: lng)
            } catch {
                print(error)
                print("Mapkit에서 좌표 가져오기")
                let lat = searchBar.selectedCoordinates.latitude
                let lng = searchBar.selectedCoordinates.longitude
                mainMapView.moveCameraToselectedAddress(lat: lat, lng: lng)
            }
        }
    }
}
