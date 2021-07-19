//
//  HeaderInformationView.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 19.07.21.
//

import UIKit

final class HeaderInformationView: UIView {
    private let title: String
    private let planDescription: String
    private let duration: String
    
    private let contentStackView = UIStackView()
    
    init(title: String, planDescription: String, duration: String) {
        self.title = title
        self.planDescription = planDescription
        self.duration = duration
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(contentStackView)
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentStackView.makeEdgesEqual(to: self)
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
     
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        titleLabel.text = title
        
        contentStackView.addArrangedSubviews([titleLabel] + makeRows())
    }
    
    private func makeRows() -> [UIStackView] {
        var rows: [UIStackView] = []
        
        rows.append(makeStackView(with: [makeImageView(with: UIImage(systemName: "flag.fill")),
                                         makeLabel(with: planDescription)]))
        rows.append(makeStackView(with: [makeImageView(with: UIImage(systemName: "hourglass")),
                                         makeLabel(with: duration)]))
        
        return rows
    }
    
    private func makeStackView(with views: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.addArrangedSubviews(views)
        return stackView
    }
    
    private func makeImageView(with image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
    private func makeLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 2
        return label
    }
}
