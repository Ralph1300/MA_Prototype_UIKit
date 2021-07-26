//
//  RoundHeaderView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 20.07.21.
//

import UIKit

protocol RoundHeaderViewDelegate: AnyObject {
    func didTapExapand()
}

enum RoundHeaderViewState {
    case expanded, collapsed, notExpandable
    
    func toggle() -> Self {
        switch self {
        case .collapsed:
            return .expanded
        case .expanded:
            return .collapsed
        case .notExpandable:
            return .notExpandable
        }
    }
}

final class RoundHeaderView: UIView {
    
    private let textLabel = UILabel()
    private let actionButton = UIButton()
    private let contentStackView = UIStackView()
    
    private let text: String
    private var state: RoundHeaderViewState
    
    weak var delegate: RoundHeaderViewDelegate?
    
    private var stateImage: UIImage? {
        switch state {
        case .collapsed:
            return UIImage(systemName: "arrow.up")
        case .expanded:
            return UIImage(systemName: "arrow.down")
        case .notExpandable:
            return nil
        }
    }
    
    init(text: String, state: RoundHeaderViewState) {
        self.text = text
        self.state = state
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setup() {
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.makeEdgesEqual(to: self)
        contentStackView.addArrangedSubviews([textLabel, actionButton])
        
        contentStackView.backgroundColor = UIColor(red: 232/255, green: 233/255, blue: 237/255, alpha: 1)
        contentStackView.layoutMargins = UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 16)
        contentStackView.isLayoutMarginsRelativeArrangement = true
        
        textLabel.text = text
        textLabel.font = UIFont.boldSystemFont(ofSize: textLabel.font.pointSize)
        
        if case .notExpandable = state {
            return
        }
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        actionButton.setImage(stateImage, for: .normal)
    }
    
    @objc private func actionButtonTapped() {
        delegate?.didTapExapand()
        state = state.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.actionButton.setImage(self.stateImage, for: .normal)
        }
    }
}
