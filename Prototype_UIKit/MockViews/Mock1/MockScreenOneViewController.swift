//
//  MockScreenOneViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 08.07.21.
//

import UIKit

final class MockScreenOneViewController: UIViewController {
    
    private let viewModel: MockScreenOneViewModel
    
    private let logoImageView = UIImageView()
    private let buttonStackView = UIStackView()
    private let wrappedButtonStackView = UIStackView()
    private let registeredLabel = UILabel()
    private let loginButton = UIButton()
    private lazy var loginView = makeEmailLoginView()
    
    init(viewModel: MockScreenOneViewModel = .init()) {
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
        createButtonLayout()
        localizeUI()
    }
    
    private func setupUI() {
        logoImageView.image = viewModel.image
        
        view.addSubviews([logoImageView, buttonStackView, loginView])
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 8
        
        wrappedButtonStackView.spacing = 8
        wrappedButtonStackView.distribution = .fillEqually
    }
    
    private func styleUI() {
        view.backgroundColor = .white
        loginButton.setTitleColor(.blue, for: .normal)
        logoImageView.contentMode = .scaleAspectFit
    }
    
    private func layoutUI() {
        [logoImageView, buttonStackView, loginView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 8.0),
            loginView.centerXAnchor.constraint(equalTo: buttonStackView.centerXAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func createButtonLayout() {
        for provider in viewModel.fullWidthProviders {
            let button = PrimaryButton()
            configure(button: button, with: provider)
            buttonStackView.addArrangedSubview(button)
        }
        for provider in viewModel.wrappedWidthProviders {
            let button = PrimaryButton()
            configure(button: button, with: provider)
            wrappedButtonStackView.addArrangedSubview(button)
        }
        buttonStackView.addArrangedSubview(wrappedButtonStackView)
    }
    
    private func makeEmailLoginView() -> UIView {
        let loginView = UIView()
        
        [registeredLabel, loginButton].forEach {
            loginView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            registeredLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            registeredLabel.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: registeredLabel.trailingAnchor, constant: 16),
            loginButton.topAnchor.constraint(equalTo: loginView.topAnchor),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        loginButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.loginViaEmail()
        }), for: .touchUpInside)
        return loginView
    }
    
    private func configure(button: UIButton, with provider: MockScreenOneViewModel.LoginProvider) {
        button.setTitle(viewModel.makeButtonTitle(for: provider), for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.providerButtonTapped(provider: provider)
        }), for: .touchUpInside)
    }
    
    private func localizeUI() {
        loginButton.setTitle("LOG IN", for: .normal)
        registeredLabel.text = "Already have an account?"
    }
    
    // MARK: - Actions

    private func providerButtonTapped(provider: MockScreenOneViewModel.LoginProvider) {
        viewModel.tapped(loginProvider: provider)
    }
}
