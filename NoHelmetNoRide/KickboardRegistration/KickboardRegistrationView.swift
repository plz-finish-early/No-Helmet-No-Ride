//
//  KickboardRegistrationView.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/28/25.
//

import UIKit

class KickboardRegistrationView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 등록 상세"
        label.textColor = .font
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 아이디 입력"
        label.textColor = .font
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "킥보드 아이디"
        textField.clearButtonMode = .always
        return textField
    }()
    
    let underLine = CALayer()
    
    let checkListLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 확인사항"
        label.textColor = .font
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let idValidatorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .font
        return label
    }()
    
    let checkListContents: [CheckBoxButton] = {
        var contents = [CheckBoxButton]()
        [
            "배터리 잔량은 충분한가?",
            "브레이크 작동은 잘 되는가?",
            "안전 점검을 통과했는가?",
            "QR코드가 훼손되지 않았는가?",
            "소리가 잘 나오는가?",
            "이물질이나 오염이 없는가?"
        ].forEach{ contents.append(CheckBoxButton(title: $0)) }
        return contents
    }()
    
    let scrollView: UIScrollView = {
        let scrollVIew = UIScrollView()
        return scrollVIew
    }()
    
    lazy var checkListStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: checkListContents)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 22
        return stackView
    }()
    
    lazy var registrationButton: UIButton = {
        let button = MainButton(title: "저장")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        self.backgroundColor = .white
        
        [
            titleLabel,
            idLabel,
            idTextField,
            idValidatorLabel,
            checkListLabel,
            scrollView,
            checkListStackView,
            registrationButton
        ].forEach{ self.addSubview($0) }
        
        scrollView.addSubview(checkListStackView)
        
        checkListContents.forEach{
            $0.snp.makeConstraints{
                $0.height.equalTo(22)
            }
        }
        
        titleLabel.snp.makeConstraints{
            $0.height.equalTo(42)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints{
            $0.height.equalTo(22)
            $0.leading.equalToSuperview().offset(28)
            $0.top.equalTo(titleLabel.snp.bottom).offset(42)
        }
        
        idTextField.snp.makeConstraints{
            $0.height.equalTo(44)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.top.equalTo(idLabel.snp.bottom).offset(20)
        }
        
        underLine.backgroundColor = UIColor.lightGray.cgColor
        idTextField.layer.addSublayer(underLine)
        
        idValidatorLabel.snp.makeConstraints{
            $0.height.equalTo(22)
            $0.leading.equalToSuperview().offset(28)
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
        }
        
        checkListLabel.snp.makeConstraints{
            $0.height.equalTo(22)
            $0.leading.equalToSuperview().offset(28)
            $0.top.equalTo(idValidatorLabel.snp.bottom).offset(60)
        }
        
        scrollView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.top.equalTo(checkListLabel.snp.bottom).offset(30)
            $0.bottom.equalTo(registrationButton.snp.top).offset(-20)
        }
        
        checkListStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        registrationButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
    }
}
