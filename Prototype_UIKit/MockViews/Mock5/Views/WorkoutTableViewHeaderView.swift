//
//  WorkoutTableViewHeaderView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 20.07.21.
//

import UIKit

final class WorkoutTableViewHeaderView: UIView {
    
    private let contentStackView = UIStackView()
    private let bookmarkingButton = PrimaryButton()
    
    init(viewModel: MockScreenFiveViewModel) {
        super.init(frame: .zero)
        layoutUI()
        setup(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(with viewModel: MockScreenFiveViewModel) {
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        contentStackView.addArrangedSubview(makeRow(icon: viewModel.descriptionIcon,
                                                    text: viewModel.workout.description))
        contentStackView.addArrangedSubview(makeRow(icon: viewModel.personalBestIcon,
                                                    text: viewModel.personalBest))
        
        bookmarkingButton.setTitle("Bookmark", for: .normal)
        bookmarkingButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    private func layoutUI() {
        [contentStackView, bookmarkingButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            bookmarkingButton.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 16),
            bookmarkingButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            bookmarkingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            bookmarkingButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func makeRow(icon: UIImage, text: String) -> UIStackView {
        let stackView = UIStackView()
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.numberOfLines = 0
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeSizeEqual(to: CGSize(width: 24, height: 24))
        
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.addArrangedSubviews([imageView, textLabel])
        return stackView
    }
}
