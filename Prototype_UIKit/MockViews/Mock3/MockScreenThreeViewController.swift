//
//  MockScreenThreeViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 17.07.21.
//

import UIKit

final class MockScreenThreeViewController: UIViewController, QuestionPageViewControllerDelegate {
    
    private let headerStackView = UIStackView()
    private let backButton = UIButton()
    private let progressBar = UIProgressView(progressViewStyle: .bar)
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    
    private let dividerView = UIView()
    private let continueButton = PrimaryButton()
    
    private let viewModel: MockScreenThreeViewModel
    private var pages: [UIViewController] = []
    
    private var currentIndex: Int {
        guard let vc = pageViewController.viewControllers?.first else { return 0 }
        return pages.firstIndex(of: vc) ?? 0
    }
    
    init(viewModel: MockScreenThreeViewModel = .init()) {
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
        updateUI()
        setupActions()
    }
    
    private func setupUI() {
        pageViewController.willMove(toParent: self)
        view.addSubviews([headerStackView, pageViewController.view, dividerView, continueButton])
        pageViewController.didMove(toParent: self)

        headerStackView.addArrangedSubviews([backButton, progressBar])
        headerStackView.alignment = .center
        headerStackView.spacing = 8
        
        pages = viewModel.questions.map {
            let vc = QuestionPageViewController(question: $0)
            vc.delegate = self
            return vc
        }
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
    private func styleUI() {
        view.backgroundColor = .white
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        dividerView.backgroundColor = .gray
        progressBar.progressTintColor = .green
        progressBar.trackTintColor = .gray
        progressBar.layer.cornerRadius = 8
    }
    
    private func layoutUI() {
        [headerStackView, pageViewController.view, dividerView, continueButton, backButton, progressBar].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerStackView.heightAnchor.constraint(equalToConstant: 32),
            
            pageViewController.view.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 16),
            pageViewController.view.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
            
            dividerView.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            continueButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            continueButton.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            backButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func updateUI() {
        continueButton.setTitle(currentIndex == 0 ? "Next" : "Finish", for: .normal)
        updateProgress(with: currentIndex)
    }
    
    private func setupActions() {
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
    
    @objc private func didTapContinue() {
        pageViewController.setViewControllers([pages[1]], direction: .forward, animated: true, completion: nil)
        updateUI()
    }
    
    @objc private func didTapBack() {
        pageViewController.setViewControllers([pages[0]], direction: .reverse, animated: true, completion: nil)
        updateUI()
    }
    
    private func updateProgress(with currentIndex: Int) {
        UIView.animate(withDuration: 0.2) {
            self.progressBar.setProgress(currentIndex == 0 ? 0.5 : 1, animated: true)
            self.backButton.isHidden = currentIndex == 0
        }
    }
    
    // MARK: - QuestionPageViewControllerDelegate
    
    func didSelectAnswer(at index: Int, for queston: Question) {
        viewModel.selectAnswer(at: index, for: queston)
    }
}
