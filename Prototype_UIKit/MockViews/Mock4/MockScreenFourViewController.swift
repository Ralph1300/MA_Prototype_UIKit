//
//  MockScreenFourViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 18.07.21.
//

import UIKit

final class MockScreenFourViewController: UIViewController {
    
    private let viewModel: MockScreenFourViewModel
    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let headerImageView = UIImageView()
    
    private let dividerView = UIView()
    private let continueButton = PrimaryButton()
    private lazy var headerInfoView = HeaderInformationView(title: viewModel.title, planDescription: viewModel.description, duration: viewModel.duration)
    private lazy var exampleWorkoutView = makeExampleView(from: viewModel.makeWorkoutRowItems())
    
    init(viewModel: MockScreenFourViewModel = .init()) {
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
        setupActions()
    }
    
    private func setupUI() {
        view.addSubviews([scrollView, dividerView, continueButton])
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([headerImageView,
                                              headerInfoView,
                                              makeDivider(),
                                              exampleWorkoutView,
                                              makeDivider()])
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        
        headerImageView.image = viewModel.headerImage
    }
    
    private func styleUI() {
        view.backgroundColor = .white
        
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        dividerView.backgroundColor = .gray
    }
    
    private func layoutUI() {
        [scrollView, contentStackView, dividerView, continueButton, headerImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentStackView.makeEdgesEqual(to: scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerImageView.heightAnchor.constraint(equalToConstant: 200),
            
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func localizeUI() {
        title = "Mock4"
        continueButton.setTitle("Continue", for: .normal)
    }
    
    private func setupActions() {
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    @objc private func didTapContinue() {
        print("Did tap continue")
    }
    
    // MARK: - Factory
    
    private func makeDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
        return view
    }
    
    private func makeExampleView(from items: [RowItem]) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
    
        stackView.addArrangedSubviews(items.map { makeRowView(from: $0, isLastRow: $0 == items.last) })
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    
    private func makeRowView(from item: RowItem, isLastRow: Bool) -> UIView {
        let rowView = UIView()
        let stackView = UIStackView()
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        descriptionLabel.numberOfLines = 0
        infoStackView.addArrangedSubviews([titleLabel, descriptionLabel])
        
        rowView.addSubview(stackView)
        
        stackView.spacing = 16
        
        let accentView: UIView
        switch item.itemType {
        case .image(let image):
            accentView = makeRoundedImageView(with: image)
        case .title(let title):
            accentView = makeEmbeddedIconView(title: title)
        }
        
        let spacerStackView = UIStackView(arrangedSubviews: [accentView, UIView()])
        spacerStackView.axis = .vertical
        stackView.addArrangedSubviews([spacerStackView, infoStackView])
        stackView.makeEdgesEqual(to: rowView)
        
        if !isLastRow {
            let dividerView = makeDivider()
            rowView.addSubview(dividerView)
            NSLayoutConstraint.activate([
                dividerView.bottomAnchor.constraint(equalTo: rowView.bottomAnchor, constant: 4),
                dividerView.trailingAnchor.constraint(equalTo: rowView.trailingAnchor),
                dividerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ])
        }
        return rowView
    }
    
    private func makeEmbeddedIconView(title: String) -> UIView {
        let view = UIView()
        let label = UILabel()
        [view, label].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        view.makeSizeEqual(to: CGSize(width: 50, height: 50))
        view.backgroundColor = .gray
        view.layer.cornerRadius = 25
        view.addSubview(label)
        label.text = title
        label.textColor = .white
        label.center(in: view)
        return view
    }
    
    private func makeRoundedImageView(with image: UIImage) -> UIView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.makeSizeEqual(to: CGSize(width: 50, height: 50))
        imageView.layer.cornerRadius = 25
        imageView.image = image
        return imageView
    }
}
