//
//  AddressSearchBarTableViewCell.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/30/25.
//
import UIKit
import SnapKit

class AddressSearchBarTableViewCell: UITableViewCell {
    
    static let identifier = "SearchBarTableViewCell"
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .clear
        
        contentView.backgroundColor = .black.withAlphaComponent(0.2)
        
        contentView.addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.verticalEdges.equalTo(contentView.snp.verticalEdges)
        }
    }
}
