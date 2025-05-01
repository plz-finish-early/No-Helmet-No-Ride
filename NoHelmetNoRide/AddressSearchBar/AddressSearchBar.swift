//
//  AddressSearchBar.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/30/25.
//
import UIKit
import SnapKit
import MapKit

class AddressSearchBar: UIView {
    
    private var timer: Timer? // 타이머 인스턴스 생성
    private var currentText: String = "" // searchBar와 텍스트 비교를 위한 변수
    
    private let searchCompleter = MKLocalSearchCompleter() // MapKit기반 자동완성 검색을 위한 인스턴스 생성
    private var searchResults = [MKLocalSearchCompletion]() { // MapKit 기반 자동완성 검색 결과를 배열로 생성
        //searchResults 값 변경시 동작 설정
        didSet {
            searchBarTableView.reloadData() // 테이블 뷰 데이터 재로딩
            updateTableViewHeight(count: searchResults.count) // 테이블 뷰 동적 크기 조정 메서드 호출
        }
    } // 지도 기반 검색으로 자동완성된 목록 인스턴스 생성
    private let networServices = NetworkService() // 네트워크 통신을 위한 인스턴스 생성
    
    private(set) var selectedAddress: String = "" // TableView에서 선택된 항목의 주소(Naver API로 호출을 위해)
    private(set) var selectedCoordinates = CLLocationCoordinate2D() // TableView에서 선택된 항목의 좌표(Naver API결과 없을 시 Mapkit의 좌표 사용)
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal // searchBar 스타일 설정
        searchBar.placeholder = "주소 검색" // searchBar 비어있을때 placholder 설정
        searchBar.searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return searchBar
    }()
    
    private let searchBarTableView = UITableView()
    private var searchBarTableViewHeight: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI() // UI 설정 메서드 호출
        setSearchBar() // searchBar 설정 메서드 호출
        setTableView() // TableView 설정 메서드 호출
        setSearchCompleter() // SearchCompleter 설정 메서드 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정 메서드
    private func configureUI() {
        [
            searchBar,
            searchBarTableView
        ].forEach{ self.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        searchBarTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            searchBarTableViewHeight = $0.height.equalTo(0).constraint // 테이블 뷰 크기 동적 지정을 위한 설정
        }
    }
    
    // searchBar 설정 메서드
    private func setSearchBar() {
        searchBar.delegate = self // serchBar 입력 감지를 위한 delegate 설정
    }
    
    // TableView 설정 메서드
    private func setTableView() {
        searchBarTableView.backgroundColor = .clear // TableView 배경색 투명 지정
        searchBarTableView.dataSource = self // TableView 데이터 표시를 위한 delegate 설정
        searchBarTableView.delegate = self // TableView 클릭시 동작 설정을 위한 delegate 설정
        //AddressSearchBarTableViewCell 재사용
        searchBarTableView.register(AddressSearchBarTableViewCell.self, forCellReuseIdentifier: AddressSearchBarTableViewCell.identifier)
        searchBarTableView.rowHeight = 50 // TableViewCell 높이 50지정
        searchBarTableView.isHidden = true // TableView 초기 설정 숨김으로 설정
    }
    
    // 테이블 뷰 크기 업데이트 메서드
    private func updateTableViewHeight(count: Int) {
        let maxHeight = CGFloat(250)
        let height = count > 4 ? maxHeight : CGFloat(count) * 50 // 셀 갯수가 4개 초과면 최대크기 250 그 이외는 셀 갯수 * 50
        searchBarTableViewHeight?.update(offset: height)
        searchBarTableView.layoutIfNeeded()
    }
    
    
    private func setSearchCompleter() {
        searchCompleter.delegate = self
//        자동완성 항목 조건 불필요로 주석처리
//        if #available(iOS 18.0, *) {
//            searchCompleter.resultTypes = [.address, .physicalFeature, .pointOfInterest, .query]
//        } else {
        searchCompleter.resultTypes = [.address] // 자동완성 항목 주소로 한정
//        }
        
        // 자동완성 검색 위치 제약
        searchCompleter.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.95, longitude: 128.25), // 대한민국 중심좌표
            span: MKCoordinateSpan(latitudeDelta: 5.9, longitudeDelta: 7.5) // 대한민국 좌우 좌표 영역
        )
    }
    
    // MapKit을 이용한 좌표 정보 검색 메서드
    private func searchCoordinate(input: MKLocalSearchCompletion) async throws -> CLLocationCoordinate2D {
        let request = MKLocalSearch.Request(completion: input) // 검색 요청을 위한 MKLocalSearch 인스턴스
        let search = MKLocalSearch(request: request) // 검색을 위한 MKLocalSearch 인스턴스
        
        let response = try await search.start() // 검색 비동기 처리
        
        //좌표값 추출
        guard let coordinate = response.mapItems.first?.placemark.coordinate else {
            throw CustomMapError.coordinateIsEmpty
        }
        return coordinate //좌표값 반환
    }
    
    // 과도한 서버요청 방지를 위한 타이머 시작 메서드(디바운싱)
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(timerDidActive),
                                          userInfo: nil,
                                          repeats: false)
    }
    
    // 타이머 정지 메서드
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // 테이블 뷰 동적 크기 조정시 테이블 뷰 표시를 위한 메서드
    private func showOverlay() {
        searchBarTableView.layer.cornerRadius = 10
        searchBarTableView.clipsToBounds = true
        
        searchBarTableView.isHidden = false
        self.addSubview(searchBarTableView)
        
        searchBarTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // 테이블 뷰 동적 크기 조정시 테이블 뷰 숨김을 위한 메서드
    private func hideOverlay() {
        searchBarTableView.isHidden = true
        searchBarTableView.removeFromSuperview()
    }
    
    
    // 0.7초 이후 searchBar의 text로 MapKit 자동완성 요청
    @objc
    private func timerDidActive() {
        searchCompleter.queryFragment = currentText
    }
}

// 테이블 뷰 델리게이트
extension AddressSearchBar: UITableViewDelegate {
    
    // 셀 선택시 동작 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 자동완성 목록의 값
        let result = searchResults[indexPath.row]
        
        // TODO: 현재 테이블 뷰 셀 선택시 주소와 좌표 모두 업데이트 함(비 효율 적임). 주소로 검색 후 없을 시 좌표값 사용으로 로직 수정 필요
        //async await 비동기 처리를 위한 Task 블록
        Task {
            do {
                // 좌표값 추출을 위한 메서드 호출(비동기 처리)
                let coordinates = try await searchCoordinate(input: result)
                selectedCoordinates = coordinates
                print(coordinates) // 디버깅을 위한 프린터 문
            } catch {
                print(error) // 디버깅을 위한 프린터 문
            }
        }
        
        // MapKit의 주소에는 대한민국 서울특별시 처럼 대한민국 이후 공백 한자리가 있어 해당 문자 포함시 제외를 위한 조건문
        if result.title.localizedStandardContains("대한민국 ") {
            selectedAddress = result.title.replacingOccurrences(of: "대한민국 ", with: "")
        } else {
            selectedAddress = result.title
        }
        tableView.deselectRow(at: indexPath, animated: true) // 선택된 테이블 뷰 셀 미선택으로 변경
        searchBar.text = selectedAddress // searchBar의 텍스트를 선택한 셀의 주소로 변경
        searchBar.endEditing(false) // 셀 선택 후 serachBar 에디팅 모드 종료
    }
}

// 테이블 뷰 데이터관리를 위한 델리게이트
extension AddressSearchBar: UITableViewDataSource {
    
    // 테이블 뷰 셀 갯수 설정 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    // 테이블 뷰 셀 설정 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressSearchBarTableViewCell.identifier, for: indexPath) as? AddressSearchBarTableViewCell else { return UITableViewCell() }
        let result = searchResults[indexPath.row]
        
        // MapKit의 주소에는 대한민국 서울특별시 처럼 대한민국 이후 공백 한자리가 있어 해당 문자 포함시 제외를 위한 조건문
        if result.title.localizedStandardContains("대한민국 ") {
            let address = result.title.replacingOccurrences(of: "대한민국 ", with: "")
            cell.setUI(input: address)
        } else {
            cell.setUI(input: result.title)
        }
        return cell
    }
}

// searchBar 동작 설정을 위한 델리게이트
extension AddressSearchBar: UISearchBarDelegate {
    
    //searchBar의 텍스트 변경시 호출되는 메서드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*
        자동완성 검색 위치 제약
        searchCompleter.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.95, longitude: 128.25),
            span: MKCoordinateSpan(latitudeDelta: 5.9, longitudeDelta: 7.5)
        )
        */
        // 타이머 디바운싱을 위해 비교할 텍스트 업데이트
        currentText = searchText
        
        //테이블 뷰 보여주기 숨기기 조건
        if searchText.count == 0 {
            hideOverlay()
        } else {
            showOverlay()
        }
        
        // 타이머 디바운싱을 위해서 타이머 시작
        startTimer()
    }
    // searchBar 텍스트 편집 시작시 호출 되는 메서드
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        becomeFirstResponder() 불필요하여 주석처리
//        showOverlay() 불필요하여 주석처리
    }
    
    // searchBar 텍스트 편집 종료시 호출 되는 메서드
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hideOverlay()
    }
}

// MapKit 자동완성 구현시 검색을 위한 델리게이트
extension AddressSearchBar: MKLocalSearchCompleterDelegate {
    
    // 검색 실패시 호출되는 메서드
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }

    // 검색결과 업데이트시 호출되는 메서드
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
//        let rawResults = completer.results
//        var filteredResults: [MKLocalSearchCompletion] = []
//        
//        for result in rawResults {
//            if !filteredResults.contains(where: {
//                $0.title == result.title}) {
//                filteredResults.append(result)
//            }
//        }
        
//        searchResults = filteredResults
        
        // 검색결과 저장
        searchResults = completer.results
    }
}
