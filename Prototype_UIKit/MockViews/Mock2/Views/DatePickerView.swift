//
//  DatePickerView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 17.07.21.
//

import UIKit

final class DatePickerView: UIView {
    
    private(set) lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    private let titleText: String
    private let selectionDidChange: (Date) -> Void
    
    private let contentStack = UIStackView()
    private let titleLabel = UILabel()
    private let selectionLabel = UILabel()
    private let pickerView = UIDatePicker()
    private let pickerContainerView = UIView()
    
    init(titleText: String, selectionDidChange: @escaping (Date) -> Void) {
        self.titleText = titleText
        self.selectionDidChange = selectionDidChange
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setup() {
        setupUI()
        layoutUI()
        styleUI()
        setupPicker()
    }
    
    private func setupUI() {
        addSubview(contentStack)
        
        contentStack.axis = .vertical
        contentStack.spacing = 8
        
        let textStack = UIStackView()
        textStack.addArrangedSubviews([titleLabel, selectionLabel])
        pickerContainerView.addSubview(pickerView)
        contentStack.addArrangedSubviews([textStack, pickerContainerView])
        
        textStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPicker)))
        
        selectionLabel.textAlignment = .right
        
        titleLabel.text = titleText
        selectionLabel.text = dateFormatter.string(from: pickerView.date)
        pickerContainerView.isHidden = true
        pickerContainerView.clipsToBounds = true
    }
    
    private func layoutUI() {
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.makeEdgesEqual(to: self)
        
        let heightConstraint = pickerContainerView.heightAnchor.constraint(equalToConstant: 216)
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            heightConstraint,
            pickerView.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
            pickerView.centerYAnchor.constraint(equalTo: pickerContainerView.centerYAnchor),
        ])
    }
    
    private func styleUI() {
        titleLabel.textColor = .black
        selectionLabel.textColor = .gray
    }
    
    private func setupPicker() {
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.datePickerMode = .date
        pickerView.addTarget(self, action: #selector(datePickerDateDidChange), for: .valueChanged)
    }
    
    @objc private func datePickerDateDidChange() {
        selectionLabel.text = dateFormatter.string(from: pickerView.date)
        selectionDidChange(pickerView.date)
    }
    
    // MARK: - Animation

    @objc private func didTapPicker() {
        UIView.animate(withDuration: 0.3) {
            self.pickerContainerView.isHidden = !self.pickerContainerView.isHidden
        }
    }
}
