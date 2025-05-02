//
//  AddressSearchBarTableViewCell.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/30/25.
//
import UIKit
import SnapKit

// 주소 서치바 테이블 뷰 셀
class AddressSearchBarTableViewCell: UITableViewCell {
    
    // 테이블뷰 셀 식별자
    static let identifier = "SearchBarTableViewCell"
    
    // 주소 라벨
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI() // UI 설정 메서드 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정 메서드
    private func configureUI() {
        self.backgroundColor = .clear // 테이블 뷰 백그라운드 투명으로 설정
        
        contentView.backgroundColor = .white.withAlphaComponent(0.8) // 컨텐츠 뷰 색상 검정 투명도 20% 설정
        
        contentView.addSubview(addressLabel) // 컨텐츠 뷰에 주소 라벨 추가
        
        // 주소 라벨 제약 설정
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.verticalEdges.equalTo(contentView.snp.verticalEdges)
        }
    }
    
    // 테이블 뷰 셀 설정 메서드
    func setUI(input: String) {
        addressLabel.text = input
    }
}
