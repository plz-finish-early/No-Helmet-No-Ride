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
    
    private var timer: Timer?
    private var currentText: String = ""
    
    let searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "주소 검색"
        searchBar.searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return searchBar
    }()
    
    let searchBarTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setSearchBar()
        setTableView()
        setSearchCompleter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
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
        }
    }
    
    func setSearchBar() {
        searchBar.delegate = self
    }

    func setTableView() {
        searchBarTableView.backgroundColor = .clear
        searchBarTableView.dataSource = self
        searchBarTableView.delegate = self
        searchBarTableView.register(AddressSearchBarTableViewCell.self, forCellReuseIdentifier: AddressSearchBarTableViewCell.identifier)
        searchBarTableView.rowHeight = 50
        searchBarTableView.isHidden = true
    }

    func setSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        searchCompleter.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.95, longitude: 128.25),
            span: MKCoordinateSpan(latitudeDelta: 5.9, longitudeDelta: 7.5)
        )
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 0.7,
                                          target: self,
                                          selector: #selector(timerDidActive),
                                          userInfo: nil,
                                          repeats: false)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func showOverlay() {
        
//        guard let parentsView = self.superview else { return }
        
        searchBarTableView.layer.cornerRadius = 10
        searchBarTableView.clipsToBounds = true
        
//        if searchBarTableView.superview == nil {
//            parentsView.addSubview(searchBarTableView)
//        }
        searchBarTableView.isHidden = false
    }
    
    func hideOverlay() {
//        searchBarTableView.removeFromSuperview()
        searchBarTableView.isHidden = true
    }
    
    @objc
    private func timerDidActive() {
        searchCompleter.queryFragment = currentText
    }
}

extension AddressSearchBar: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = searchResults[indexPath.row]
        print(address.title)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddressSearchBar: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressSearchBarTableViewCell.identifier, for: indexPath) as? AddressSearchBarTableViewCell else { return UITableViewCell() }
        let result = searchResults[indexPath.row]
        cell.addressLabel.text = "\(result.title) \(result.subtitle)"
        return cell
    }
}

extension AddressSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.95, longitude: 128.25),
            span: MKCoordinateSpan(latitudeDelta: 5.9, longitudeDelta: 7.5)
        )
        
        currentText = searchText
        
        if searchText.count == 0 {
            hideOverlay()
        } else {
            showOverlay()
        }
        
        startTimer()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showOverlay()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hideOverlay()
    }
}

extension AddressSearchBar: MKLocalSearchCompleterDelegate {
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchBarTableView.reloadData()
    }
}
