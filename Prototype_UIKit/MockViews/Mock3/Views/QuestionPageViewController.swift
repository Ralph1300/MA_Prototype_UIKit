//
//  QuestionPageViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 17.07.21.
//

import UIKit

protocol QuestionPageViewControllerDelegate: AnyObject {
    func didSelectAnswer(at index: Int, for queston: Question)
}

final class QuestionPageViewController: UIViewController {
    
    weak var delegate: QuestionPageViewControllerDelegate?
    
    private let question: Question
    
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private lazy var headerStackView = makeHeaderStackView()
    private let answerStack = UIStackView()
    private var answerViews: [AnswerView] = []
    
    init(question: Question) {
        self.question = question
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
    }
    
    private func setupUI() {
        view.addSubview(contentStackView)
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        
        answerStack.spacing = 16
        answerStack.axis = .vertical
        
        contentStackView.addArrangedSubviews([headerStackView, answerStack, UIView()])
        answerViews = makeAnswerViews()
        answerStack.addArrangedSubviews(answerViews)
    }
    
    private func styleUI() {
        view.backgroundColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func layoutUI() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.makeEdgesEqual(to: view)
        contentStackView.setCustomSpacing(48, after: headerStackView)
    }
    
    private func makeHeaderStackView() -> UIView {
        let topStackView = UIStackView()
        topStackView.axis = .vertical
        topStackView.spacing = 8
        
        topStackView.addArrangedSubviews([titleLabel, descriptionLabel])
        titleLabel.text = question.title
        descriptionLabel.text = question.description
        return topStackView
    }
    
    private func makeAnswerViews() -> [AnswerView] {
        var answerViews: [AnswerView] = []
        for (idx, answer) in question.potentialAnswers.enumerated() {
            answerViews.append(AnswerView(text: answer, index: idx, didTap: didSelectAnswer(at:)))
        }
        return answerViews
    }
    
    private func didSelectAnswer(at index: Int) {
        delegate?.didSelectAnswer(at: index, for: question)
        for (idx, answerView) in answerViews.enumerated() where idx != index {
            answerView.isSelected = false
        }
    }
}
