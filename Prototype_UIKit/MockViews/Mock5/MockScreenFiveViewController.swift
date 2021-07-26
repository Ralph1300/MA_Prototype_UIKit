//
//  MockScreenFiveViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 20.07.21.
//

import UIKit

final class WorkoutDiffableDataSource: UITableViewDiffableDataSource<WorkoutDetailSection, Exercise> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snapshot().sectionIdentifiers[section].text
    }
}

final class MockScreenFiveViewController: UIViewController, UITableViewDelegate, RoundHeaderViewDelegate {
    private let viewModel: MockScreenFiveViewModel
    
    private let tableView = UITableView()
    
    private let dividerView = UIView()
    private let continueButton = PrimaryButton()
    
    private var dataSource: WorkoutDiffableDataSource?
    
    init(viewModel: MockScreenFiveViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applySnapshot()
    }
    
    // MARK: - Private
    
    private func setup() {
        setupUI()
        styleUI()
        layoutUI()
        localizeUI()
        setupActions()
        
        setupDataSource()
    }
    
    private func setupUI() {
        view.addSubviews([tableView, dividerView, continueButton])
    }
    
    private func styleUI() {
        view.backgroundColor = .white
        
        dividerView.backgroundColor = .gray
    }
    
    private func layoutUI() {
        [tableView, dividerView, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func localizeUI() {
        title = "Mock5"
        continueButton.setTitle("Continue", for: .normal)
    }
    
    private func setupActions() {
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    @objc private func didTapContinue() {
        print("Did tap continue")
    }
    
    private func setupDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        dataSource = WorkoutDiffableDataSource(tableView: tableView,
                                               cellProvider: cell(in:indexPath:exercise:))
        
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    private func cell(in tableView: UITableView, indexPath: IndexPath, exercise: Exercise) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)") else {
            return nil
        }
        cell.imageView?.image = viewModel.exerciseImage
        cell.textLabel?.text = "\(exercise.value) \(exercise.name)"
        return cell
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<WorkoutDetailSection, Exercise>()
        snapshot.appendSections(viewModel.sections)
        
        for section in viewModel.sections {
            snapshot.appendItems(viewModel.items(for: section), toSection: section)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        let headerView = WorkoutTableViewHeaderView(viewModel: viewModel)
        headerView.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 220))
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = RoundHeaderView(text: viewModel.sections.first?.text ?? "", state: .expanded)
            header.delegate = self
            return header
        }
        return nil
    }
    
    // MARK: - RoundHeaderViewDelegate
    
    func didTapExapand() {
        viewModel.warmupIsShown.toggle()
        applySnapshot()
    }
}
