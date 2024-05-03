//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI

class CharacterListViewController: UIViewController {
    
    private let viewModel: CharacterListViewModel
    
    private let titleLabel = UILabel()
    private let filterStackView = UIStackView()
    private var selectedFilters = Set<String>()
    private(set) var tableView = UITableView()
    
    var onSelect: ((CharacterListCellViewModel) -> Void)?
    
    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedFilters = viewModel.selectedFilters
        setupLayout()
        viewModel.fetchNextPage { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        
        titleLabel.font = Design.Font.latoBold(size: 32)
        titleLabel.text = viewModel.title
        titleLabel.textColor = UIColor.accent
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        filterStackView.spacing = 10
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupTableView()
        setupHierarchy()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(filterStackView)
        view.addSubview(tableView)
        
        addFilters()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Design.Layout.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Design.Layout.defaultPadding),
            
            filterStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Design.Layout.defaultPadding),
            filterStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: filterStackView.bottomAnchor, constant: Design.Layout.defaultPadding),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func updateFilterStackView() {
        filterStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        addFilters()
    }
    
    private func addFilters() {
        viewModel.filters.forEach { filter in
            let rootView = CharacterListFilterButtonView(text: filter, isActive: isFilterActive(filter)) { [weak self] in
                guard let self else { return }
                self.viewModel.filter(by: filter) { selectedFilters in
                    self.selectedFilters = selectedFilters
                    self.updateFilterStackView()
                    self.tableView.reloadData()
                }
            }
            let hostingController = UIHostingController(rootView: rootView)
            hostingController.view.setContentCompressionResistancePriority(.required, for: .horizontal)
            hostingController.view.setContentHuggingPriority(.required, for: .horizontal)
            
            addChild(hostingController)
            filterStackView.addArrangedSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }
    
    private func isFilterActive(_ filter: String) -> Bool {
        selectedFilters.contains(filter)
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.reuseIdentifier, for: indexPath) as! CharacterListCell
        
        let model = viewModel.cellViewModel(at: indexPath) { receivedImage in
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        cell.contentConfiguration = UIHostingConfiguration {
            CharacterListCellView(name: model.name, species: model.species, image: model.image)
                .padding()
                .background(model.status.background)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > viewModel.distanceFromEndCell {
            viewModel.fetchNextPage() {
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelect?(viewModel.filteredCharacters[indexPath.row])
    }
}
