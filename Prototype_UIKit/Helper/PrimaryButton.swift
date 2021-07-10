//
//  PrimaryButton.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 08.07.21.
//

import UIKit

final class PrimaryButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .blue
        titleLabel?.textColor = .white
        layer.cornerRadius = 24
    }
    
    // MARK: - UIView
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width, height: 48)
    }
}
