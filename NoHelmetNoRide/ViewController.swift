//
//  ViewController.swift
//  NoHelmetNoRide
//
//  Created by NH on 4/25/25.
//

import UIKit
import NMapsMap // 네이버 지도 SDK
import CoreLocation // 위치 정보 가져오기
import SnapKit

class ViewController: UIViewController {
    var locationManager = CLLocationManager() // 위치 업데이트를 위한 매니저
    var lat: Double = 0.0 // 탭한 위도 저장
    var lng: Double = 0.0 // 탭한 경도 저장
    lazy var naverMapView = NMFNaverMapView(frame: view.frame) // 네이버 지도 뷰, 화면 크기만큼 생성

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = LoginViewController()
        let login = UINavigationController(rootViewController: vc)
        
        setup(login)
        //setNaverMap()
    }
    
    func setup(_ child: UIViewController) {
        addChild(child)
        self.view.addSubview(child.view)
        
        child.view.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        // 앤 뭐야
        child.didMove(toParent: self)
    }
    
    func setNaverMap() {
        view.backgroundColor = .red // 배경색 빨간색 설정 (디버깅용으로 보기 쉽게)
        
        // 네이버 맵 객체
        //let mapView = NMFMapView(frame: view.frame)
        //let naverMapView = NMFNaverMapView(frame: view.frame)
        
        // 네이버 지도 관련 설정
        naverMapView.showLocationButton = true // 내 위치 버튼 보이게
        naverMapView.showCompass = true // 나침반 버튼 보이게
        
        view.addSubview(naverMapView) // 지도 뷰를 메인 뷰에 추가
        
        naverMapView.mapView.touchDelegate = self // 지도 터치 이벤트를 현재 VC로 위임
        
        locationManager.delegate = self // 위치 업데이트 이벤트를 현재 VC로 위임
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 가장 정확한 위치 요청
        locationManager.requestWhenInUseAuthorization() // 앱 사용 중에만 위치 권한 요청
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation() // 위치 업데이트 시작
            
            guard let location = locationManager.location else { return }
            print(location.coordinate) // 현재 좌표 출력
        } else {
            print("위치 서비스 Off 상태")
        }
    }
}

extension ViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("탭: \(latlng.lat), \(latlng.lng)")
        lat = latlng.lat // 탭한 위도 저장
        lng = latlng.lng // 탭한 경도 저장
        
        let marker = NMFMarker() // 새 마커 생성
        marker.position = NMGLatLng(lat: lat, lng: lng) // 탭한 좌표로 위치 설정
        marker.mapView = naverMapView.mapView // 지도에 추가
        
        // 탭 하면 마커 지우기
        // 👇 터치 리스너 추가
//        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
//            marker.mapView = nil  // 마커 삭제
//            return true // 이벤트 소비 완료
//        }
        marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
            guard let self = self else { return true } // self가 살아있을 때만 진행
            
            let modalVC = ModalViewController() // 모달로 띄울 뷰 컨트롤러 생성
            modalVC.modalPresentationStyle = .pageSheet // 페이지 시트 모달 스타일로 설정
            
            if let sheet = modalVC.sheetPresentationController {
                // 30% 높이로 시작하는 custom detent 생성
                let smallDetent = UISheetPresentationController.Detent.custom { context in
                    return context.maximumDetentValue * 0.3 // 30% 높이
                }
                
                sheet.detents = [
                    smallDetent,
                    .large() // 나머지는 전체 화면까지 드래그 가능
                ]
                
                sheet.prefersGrabberVisible = true // 손잡이 보이게
            }
            self.present(modalVC, animated: true, completion: nil) // 모달 띄우기
            return true
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return } // 가장 최근 위치 가져오기
        
        print("현재 위치: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // 현재 위치로 카메라 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
        cameraUpdate.animation = .easeIn // 부드럽게 이동
        naverMapView.mapView.moveCamera(cameraUpdate)
        
        // 위치 업데이트 그만 (한 번만 받고 싶으면)
        locationManager.stopUpdatingLocation() // 위치 업데이트 중지 (배터리 절약)
    }
}
