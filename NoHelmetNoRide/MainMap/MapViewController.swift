//
//  MapViewController.swift
//  NoHelmetNoRide
//
//  Created by JIN LEE on 4/30/25.
//

import UIKit
import SnapKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var lat: Double = 0.0
    var lng: Double = 0.0
    lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var naverMapView = NMFNaverMapView(frame: view.frame)
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
}

extension MapViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        
        //hideBottomSheet()
        
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
            
            //self?.showBottomSheet()
            return true
        }
    }
}

// 현재 위치로 카메라 이동하는 익스텐션 코드
extension MapViewController: CLLocationManagerDelegate {
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

