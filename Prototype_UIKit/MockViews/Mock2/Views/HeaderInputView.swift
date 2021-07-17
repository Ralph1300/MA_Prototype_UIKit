//
//  HeaderInputView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 13.07.21.
//

import UIKit

protocol HeaderInputViewDelegate: AnyObject {
    func didRequestImageUpdate(didFinish: @escaping (UIImage?) -> Void)
    func modelDidUpdate(image: UIImage?, firstName: String, lastName: String)
}

final class HeaderInputView: UIView {
    private let userImageView = UIImageView()
    private let userImageButton = UIButton()
    private let firstNameTextfield = UITextField()
    private let lastNameTextField = UITextField()
    
    weak var delegate: HeaderInputViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        firstNameTextfield.placeholder = "First Name"
        lastNameTextField.placeholder = "Last Name"
        
        firstNameTextfield.borderStyle = .roundedRect
        lastNameTextField.borderStyle = .roundedRect
        
        let content = makeUserImageAndNameView()
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)
        content.makeEdgesEqual(to: self)
    }
    
    private func makeUserImageView() -> UIView {
        let userImageInteractionView = UIView()
        [userImageView, userImageButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            userImageInteractionView.addSubview($0)
        }
        
        userImageView.makeSizeEqual(to: CGSize(width: 100, height: 100))
        userImageView.makeEdgesEqual(to: userImageInteractionView)
        userImageButton.makeEdgesEqual(to: userImageView)
        
        userImageView.backgroundColor = .gray
        userImageView.layer.cornerRadius = 50
        userImageView.clipsToBounds = true
        userImageButton.layer.cornerRadius = 50
        
        userImageButton.setImage(UIImage(systemName: "camera"), for: .normal)
        userImageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        return userImageInteractionView
    }
    
    private func makeUserImageAndNameView() -> UIView {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.alignment = .center
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 8
        textStack.addArrangedSubviews([firstNameTextfield, lastNameTextField])
        stackView.addArrangedSubviews([makeUserImageView(), textStack])
        return stackView
    }
    
    // MARK: - Internal
    
    func requestInput() {
        delegate?.modelDidUpdate(image: userImageView.image,
                                 firstName: firstNameTextfield.text ?? "",
                                 lastName: lastNameTextField.text ?? "")
    }
    
    // MARK: - Actions
    
    @objc private func imageButtonTapped() {
        delegate?.didRequestImageUpdate(didFinish: { [weak self] image in
            self?.userImageButton.setImage(nil, for: .normal)
            self?.userImageView.image = image
        })
    }
}
