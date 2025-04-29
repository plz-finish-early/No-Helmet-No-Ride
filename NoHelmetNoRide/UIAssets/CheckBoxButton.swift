//
//  CheckBoxButton.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/28/25.
//
import UIKit

class CheckBoxButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    init(title: String) {
        super.init(frame: .zero)
        self.configuration = .plain()
        self.setTitle(title, for: .normal)
        setConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfig(){
        
        self.configuration?.imagePadding = 12
        self.configuration?.contentInsets = .zero
        self.configuration?.baseForegroundColor = .font
        self.configuration?.baseBackgroundColor = .clear
        
        self.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        
        let configImageColor = UIImage.SymbolConfiguration(paletteColors: [.white, .gray, .systemBlue])
        
        self.setImage(UIImage(systemName: "checkmark.circle.fill",
                              withConfiguration: configImageColor),
                      for: .selected)
        self.setImage(UIImage(systemName: "checkmark.circle",
                              withConfiguration: configImageColor),
                      for: .normal)
    }
    
    @objc private func toggleButton(){
        switch isSelected {
        case true:
            print("true -> false")
            isSelected = false
        case false:
            print("flase -> true")
            isSelected = true
        }
    }
}
