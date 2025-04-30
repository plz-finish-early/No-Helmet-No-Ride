//
//  MainMapViewController.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/28/25.
//

import UIKit
import SnapKit
import NMapsMap
import CoreLocation

class MainMapViewController: UIViewController {
    
    var customSegmentedControl = UISegmentedControl()
    let bottomSheetView = CustomBottomSheetView()
    // 바텀시트(Bottom Sheet) 뷰의 위치를 제어하는 오토레이아웃(NSLayoutConstraint) 제약조건
    var bottomSheetViewBottomConstraint: NSLayoutConstraint!
    let ridingKickboardView = RidingKickboardView()
    let usingKickboardButton = UsingKickboardButton(title: "킥보드 이용하기")
    
    //MARK: NaverMap
    var locationManager = CLLocationManager()
    var lat: Double = 0.0
    var lng: Double = 0.0
    lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - NaverMap
        
        // 현재 위치 및 확대 축소 버튼
        naverMapView.showLocationButton = true
        naverMapView.positionMode = .direction
        
        view.addSubview(naverMapView)
        
        // 터치 델리게이트
        naverMapView.mapView.touchDelegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        //DispatchQueue로 무시무시한 보라색 에러 수정
        DispatchQueue.global().async { [self] in
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                locationManager.startUpdatingLocation()
                guard let location = locationManager.location else { return }
                print(location.coordinate)
            } else {
                print("위치 서비스 Off 상태")
            }
        }
        //MARK: - UI
        
        configureSegmentedControl()
        setupUI()
        setupConstraints()
        
        
        
        bottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 260 // 초기에는 화면 밖에 위치
        )
        
        bottomSheetView.delegate = self
        bottomSheetViewBottomConstraint?.isActive = true
        // 바텀시트를 뷰의 계층 가장 상단에 위치하게
        view.bringSubviewToFront(bottomSheetView)
    }
    
    private func configureSegmentedControl() {
        customSegmentedControl = UISegmentedControl(items: ["지도", "킥보드 등록", "마이페이지"])
        
        customSegmentedControl.selectedSegmentIndex = 0
        
        customSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.font.withAlphaComponent(0.7),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ], for: .normal)
        
        customSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.font,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ], for: .selected)
        
        //segmentedControll 백그라운드 및 셀렉터값 모두 없애기
        customSegmentedControl.selectedSegmentTintColor = .clear
        customSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        customSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    // 현재 위치 권한 설정 상태 코드
    func checkCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .authorized:
            print("authorized")
        @unknown default:
            fatalError()
        }
    }
    
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
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        [
            customSegmentedControl,
            bottomSheetView,
            ridingKickboardView,
            usingKickboardButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        // 높이 제약 추가
        ridingKickboardView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // 상단 위치 제약 추가
        ridingKickboardView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        // 기존 제약
        let c1 = ridingKickboardView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: -54)
        c1.priority = .defaultHigh

        let c2 = ridingKickboardView.bottomAnchor.constraint(greaterThanOrEqualTo: usingKickboardButton.topAnchor, constant: -116)
        c2.priority = .required

        NSLayoutConstraint.activate([c1, c2])

        NSLayoutConstraint.activate([
            customSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            customSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            customSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customSegmentedControl.heightAnchor.constraint(equalToConstant: 26),
            
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 260),
            
            ridingKickboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            usingKickboardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            usingKickboardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            usingKickboardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}

extension MainMapViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        
        hideBottomSheet()
        
        print("탭: \(latlng.lat), \(latlng.lng)")
        // 마커 추가용 코드
        lat = latlng.lat
        lng = latlng.lng
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = naverMapView.mapView
        
        // 마커 생성 시 데이터 추가
        marker.userInfo = [
            "title": "킥보드 위치",
            "address": "서울시 강남구"
        ]
        
        // 터치 핸들러에서 데이터 추출
        marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
            guard let marker = overlay as? NMFMarker,
                  let title = marker.userInfo["title"] as? String,
                  let address = marker.userInfo["address"] as? String else { return true }
            
            self?.showBottomSheet()
            return true
        }
    }
}

// 현재 위치로 카메라 이동하는 익스텐션 코드
extension MainMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print("현재 위치: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // 현재 위치로 카메라 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
        cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)
        
        // 위치 업데이트 그만 (한 번만 받고 싶으면)
        locationManager.stopUpdatingLocation()
    }
}

extension MainMapViewController: CustomBottomSheetViewDelegate {
    func didRequestHide() {
        hideBottomSheet()
    }
}
