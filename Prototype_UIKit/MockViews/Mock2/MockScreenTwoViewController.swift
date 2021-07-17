//
//  MockScreenTwoViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 10.07.21.
//

import UIKit

final class MockScreenTwoViewController: UIViewController, HeaderInputViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var bottomStackView = UIStackView()
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerInputView = HeaderInputView()
    private lazy var genderSelectionView = GenderSelectionView(preselectedGender: .male, genderSelectionDidChange: genderDidUpdate)
    private lazy var countrySelectionPicker = PickerView<Country>(titleText: "Country", content: viewModel.countries, selectionDidChange: countryDidUpdate(country:))
    private lazy var dateSelectionPicker = DatePickerView(titleText: "Birthday", selectionDidChange: dateDidUpdate(date:))
    
    private let continueButton = PrimaryButton()
    
    private let viewModel: MockScreenTwoViewModel
    
    init(viewModel: MockScreenTwoViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setup() {
        setupUI()
        styleUI()
        layoutUI()
        localizeUI()
        
        headerInputView.delegate = self
    }
    
    private func setupUI() {
        view.addSubviews([scrollView, continueButton])
        scrollView.addSubview(contentView)
        
        contentView.addSubviews([headerInputView, genderSelectionView, dividerView, bottomStackView])
        
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 16
        
        bottomStackView.addArrangedSubviews([emailTextField, passwordTextField, countrySelectionPicker, dateSelectionPicker])
        
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    private func styleUI() {
        view.backgroundColor = .white
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        emailTextField.borderStyle = .roundedRect
    }
    
    private func layoutUI() {
        [scrollView, contentView, headerInputView, genderSelectionView, bottomStackView, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        contentView.makeEdgesEqual(to: scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: 16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerInputView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerInputView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            genderSelectionView.topAnchor.constraint(equalTo: headerInputView.bottomAnchor, constant: 16),
            genderSelectionView.leadingAnchor.constraint(equalTo: headerInputView.leadingAnchor),
            
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.topAnchor.constraint(equalTo: genderSelectionView.bottomAnchor, constant: 16),
            
            bottomStackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            bottomStackView.leadingAnchor.constraint(equalTo: headerInputView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: headerInputView.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func localizeUI() {
        continueButton.setTitle("Continue", for: .normal)
        
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    // MARK: - Actions
    
    private func genderDidUpdate(gender: Gender) {
        viewModel.gender = gender
    }
    
    private func countryDidUpdate(country: Country) {
        viewModel.country = country
    }
    
    private func dateDidUpdate(date: Date) {
        viewModel.birthday = date
    }
    
    @objc private func didTapContinue() {
        headerInputView.requestInput()
        
        viewModel.register()
    }
    
    // MARK: - HeaderInputViewDelegate
    
    private var imageRequest: ((UIImage?) -> Void)?
    
    func modelDidUpdate(image: UIImage?, firstName: String, lastName: String) {
        viewModel.userImage = image
        viewModel.firstName = firstName
        viewModel.lastName = lastName
    }
    
    func didRequestImageUpdate(didFinish: @escaping (UIImage?) -> Void) {
        imageRequest = didFinish
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        DispatchQueue.main.async {
            self.imageRequest?(image)
        }
        dismiss(animated: true)
    }
}
