//
//  GenderSelectionView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 13.07.21.
//

import UIKit

final class GenderSelectionView: UIView {
    
    private let genderSelectionDidChange: (Gender) -> Void
    private var selectedGender: Gender {
        didSet {
            guard selectedGender != oldValue else {
                return
            }
            adaptSelectionState(for: selectedGender)
            genderSelectionDidChange(selectedGender)
        }
    }
    
    private lazy var maleButton = makeGenderSelectionButton(gender: .male)
    private lazy var femaleButton = makeGenderSelectionButton(gender: .female)
    private lazy var otherButton = makeGenderSelectionButton(gender: .other)
    
    init(preselectedGender: Gender, genderSelectionDidChange: @escaping (Gender) -> Void) {
        self.selectedGender = preselectedGender
        self.genderSelectionDidChange = genderSelectionDidChange
        super.init(frame: .zero)
        setup()
        adaptSelectionState(for: selectedGender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [maleButton, femaleButton, otherButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
        NSLayoutConstraint.activate([
            maleButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            maleButton.topAnchor.constraint(equalTo: topAnchor),
            maleButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            femaleButton.leadingAnchor.constraint(equalTo: maleButton.trailingAnchor, constant: 16),
            femaleButton.topAnchor.constraint(equalTo: topAnchor),
            femaleButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            otherButton.leadingAnchor.constraint(equalTo: femaleButton.trailingAnchor, constant: 16),
            otherButton.topAnchor.constraint(equalTo: topAnchor),
            otherButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            otherButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func makeGenderSelectionButton(gender: Gender) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.setTitle(gender.text, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapGenderButton(sender:)), for: .touchUpInside)
        return button
    }
    
    @objc private func didTapGenderButton(sender: UIButton) {
        switch sender {
        case let sender where sender === maleButton:
            selectedGender = .male
        case let sender where sender === femaleButton:
            selectedGender = .female
        case let sender where sender === otherButton:
            selectedGender = .other
        default:
            assertionFailure("How did we end up here?")
        }
    }
    
    private func adaptSelectionState(for gender: Gender) {
        let selectedButton = button(for: gender)
        let tint = gender.color
        [maleButton, femaleButton, otherButton].forEach {
            $0.tintColor = .gray
            $0.setTitleColor(.gray, for: .normal)
        }
        selectedButton.tintColor = tint
        selectedButton.setTitleColor(tint, for: .normal)
    }
    
    private func button(for gender: Gender) -> UIButton {
        switch gender {
        case .male:
            return maleButton
        case .female:
            return femaleButton
        case .other:
            return otherButton
        }
    }
}

extension Gender {
    fileprivate var text: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .other:
            return "Other"
        }
    }
    
    fileprivate var color: UIColor {
        switch self {
        case .female:
            return .red
        case .male:
            return .blue
        case .other:
            return .green
        }
    }
}
