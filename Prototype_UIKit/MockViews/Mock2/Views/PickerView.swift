//
//  PickerView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 16.07.21.
//

import UIKit

protocol Pickable {
    var descriptionText: String { get }
}

final class PickerView<T: Pickable>: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let titleText: String
    private let content: [T]
    private let selectionDidChange: (T) -> Void
    
    private let contentStack = UIStackView()
    private let titleLabel = UILabel()
    private let selectionLabel = UILabel()
    private let pickerContainerView = UIView()
    private let pickerView = UIPickerView()
    
    init(titleText: String, content: [T], selectionDidChange: @escaping (T) -> Void) {
        self.titleText = titleText
        self.content = content
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
        selectionLabel.text = content[0].descriptionText
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
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    // MARK: - Animation

    @objc private func didTapPicker() {
        UIView.animate(withDuration: 0.3) {
            self.pickerContainerView.isHidden = !self.pickerContainerView.isHidden
        }
    }
    
    // MARK: - UIPickerViewDataSource
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return content.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return content[row].descriptionText
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionDidChange(content[row])
        selectionLabel.text = content[row].descriptionText
    }
}
