//
//  BaseMapViewController.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/30/25.
//

import UIKit
import SnapKit
import NMapsMap
import CoreLocation

/// 지도 상호작용 이벤트를 전달하는 프로토콜
protocol MapViewDelegate: AnyObject {
    /// 마커를 탭했을 때 호출
    func didTapMarker(title: String, address: String)
    /// 지도 빈 곳을 탭했을 때 호출
    func didTapMap()
}

/// 네이버 지도 및 위치, 마커 기능을 담당하는 베이스 뷰컨트롤러
class BaseMapViewController: UIViewController {

    // MARK: - Delegate
    weak var delegate: MapViewDelegate?

    // MARK: - 위치 및 지도 관련 프로퍼티
    let locationManager = CLLocationManager()
    lazy var naverMapView = NMFNaverMapView(frame: .zero) // 지도 뷰

    // 현재 좌표 저장용
    var lat: Double = 0.0
    var lng: Double = 0.0

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupLocationManager()
    }

    // MARK: - 지도 뷰 설정
    func setupMapView() {
        // 지도 뷰 추가 및 레이아웃
        view.addSubview(naverMapView)
        naverMapView.snp.makeConstraints { $0.edges.equalToSuperview() }

        // 지도 옵션 설정
        naverMapView.showLocationButton = true
        naverMapView.positionMode = .direction

        // 지도 터치 이벤트 델리게이트 연결
        naverMapView.mapView.touchDelegate = self
    }

    // MARK: - 위치 매니저 설정
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        // 위치 서비스 활성화 시 즉시 위치 업데이트 시작
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                self.locationManager.startUpdatingLocation()
                if let location = self.locationManager.location {
                    print(location.coordinate)
                }
            } else {
                print("위치 서비스 Off 상태")
            }
        }
    }

    // MARK: - 위치 권한 상태 체크 (필요시 사용)
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
}

// MARK: - 지도 터치 이벤트 처리
extension BaseMapViewController: NMFMapViewTouchDelegate {
    /// 지도 빈 곳을 탭하면 호출됨
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        delegate?.didTapMap()
        print("지도 탭: \(latlng.lat), \(latlng.lng)")

        // 마커 추가 예시 (원한다면)
        lat = latlng.lat
        lng = latlng.lng

        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = naverMapView.mapView

        // 마커에 정보 저장
        marker.userInfo = [
            //나중에 데이터 연결하고 킥보드ID 등 들어가야 하는 데이터로 변환하면 됨!!
            "title": "킥보드 위치",
            "address": "서울시 강남구"
        ]

        // 마커 터치 핸들러 설정
        marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
            guard let marker = overlay as? NMFMarker,
                  let title = marker.userInfo["title"] as? String,
                  let address = marker.userInfo["address"] as? String else { return true }
            self?.delegate?.didTapMarker(title: title, address: address)
            return true
        }
    }
}

// MARK: - 위치 업데이트 처리
extension BaseMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("현재 위치: \(location.coordinate.latitude), \(location.coordinate.longitude)")

        // 지도 카메라를 현재 위치로 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
        cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)

        // 위치 업데이트 중단 (원한다면)
        locationManager.stopUpdatingLocation()
    }
}
