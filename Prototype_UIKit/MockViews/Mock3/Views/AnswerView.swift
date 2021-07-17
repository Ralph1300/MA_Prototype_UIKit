//
//  AnswerView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 17.07.21.
//

import UIKit

final class AnswerView: UIView {
    
    private let text: String
    var isSelected: Bool {
        didSet {
            selectionImageView.image = selectionImage
        }
    }
    private let index: Int
    private let didTap: (Int) -> Void
    
    private let contentStackView = UIStackView()
    private let textLabel = UILabel()
    private let selectionImageView = UIImageView()
    
    private var selectionImage: UIImage? {
        return UIImage(systemName: isSelected ? "checkmark.circle.fill" : "circle")
    }
    
    init(text: String, index: Int, isSelected: Bool = false, didTap: @escaping (Int) -> Void) {
        self.text = text
        self.index = index
        self.isSelected = isSelected
        self.didTap = didTap
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setup() {
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubviews([textLabel, selectionImageView])
        
        textLabel.text = text
        selectionImageView.image = selectionImage
        selectionImageView.clipsToBounds = true
        selectionImageView.contentMode = .scaleAspectFit
        
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        selectionImageView.translatesAutoresizingMaskIntoConstraints = false
        selectionImageView.makeSizeEqual(to: CGSize(width: 24, height: 24))
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setupActions() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    @objc private func didTapView() {
        isSelected.toggle()
        didTap(index)
    }
}
