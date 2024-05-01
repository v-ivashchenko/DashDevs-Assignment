//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {

    private(set) var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
}
