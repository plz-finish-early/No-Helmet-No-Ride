//
//  KickboardRegistrationWithMap.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/28/25.
//
import UIKit

class KickboardRegistrationWithMap: BaseMapViewController {
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "핀을 움직여 위치를 선택하세요"
        label.textColor = .font
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = .sub3
        label.layer.cornerRadius = 23
        label.layer.masksToBounds = true
        return label
    }()
    
    let centerPin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .pin)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy private var registerButton: UIButton = {
        let button = UsingKickboardButton(title: "킥보드 등록하기")
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func updateMarker() {
        for kickboard in kickboardData {
            makeMarker(kickboard: kickboard)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        [
            topLabel,
            centerPin,
            registerButton
        ].forEach{ view.addSubview($0) }
        
        topLabel.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.equalToSuperview().offset(45)
            $0.horizontalEdges.equalToSuperview().inset(88)
        }
        
        centerPin.snp.makeConstraints {
            let height = 44
            $0.width.equalTo(34)
            $0.height.equalTo(height)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(0 - height/2)
        }

        registerButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func registerButtonTapped() {
        
        let coordinate = self.getCenterofMap()
        let kickboardRegistrationViewController = KickboardRegistrationViewController()
        
        kickboardRegistrationViewController.coordinate = (coordinate.lat, coordinate.lng)
        kickboardRegistrationViewController.delegate = self
        kickboardRegistrationViewController.modalPresentationStyle = .formSheet
        self.present(kickboardRegistrationViewController, animated: true)
    }
}


extension KickboardRegistrationWithMap: RegisterViewDismissDelegate {
    func dismiss() {
        self.updateData()
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
