//
//  SafetyInstructions.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/28/25.
//
import UIKit

class SafetyInstructions: UIView {
    
    weak var delegate: SafetyInstructionsViewDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .warning
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let safetyRuleText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .sub3
        return textView
    }()

    
    lazy private var confirmButton: UIButton = {
        let button = MainButton(title: "확인했습니다", font: .boldSystemFont(ofSize: 24), color: .main)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        self.backgroundColor = .sub3
        [
            imageView,
            safetyRuleText,
            confirmButton
        ].forEach{ self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        safetyRuleText.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-32)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureText() {
        let text = """
        제2종 원동기장치자전거 이상의 면허 필수!
        도로교통법상 안전모 미착용시 벌금 2만원!
        음주 운전은 절대금지!
        2인 이상 탑승도 절대금지!
        차도 및 자전거도로 주행 가능, 인도 불가능!
        """
        
        let highlightedText = ["면허 필수!",
                               "안전모 미착용",
                               "음주 운전",
                               "2인 이상 탑승",
                               "인도 불가능!"]
        let attributedString = NSMutableAttributedString(string: text)
        
        let normalFont = UIFont.systemFont(ofSize: 16, weight: .heavy)
        let hilightedFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        textStyle.lineSpacing = normalFont.pointSize * 1.6
        
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.font, value: normalFont, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.font, range: range)
        attributedString.addAttribute(.paragraphStyle, value: textStyle, range: range)
        
        for word in highlightedText {
            let range = (text as NSString).range(of: word)
            attributedString.addAttribute(.font, value: hilightedFont, range: range)
            attributedString.addAttribute(.foregroundColor, value: UIColor.sub2, range: range)
        }
        
        safetyRuleText.attributedText = attributedString
    }
    
    @objc private func confirmButtonTapped() {
        print("confirmButtonTapped")
        delegate?.didTapConfirm()
    }
}

protocol SafetyInstructionsViewDelegate: AnyObject {
    func didTapConfirm()
}
