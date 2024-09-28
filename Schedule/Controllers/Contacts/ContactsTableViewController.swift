import UIKit

class ContactsTableViewController: UITableViewController {
    
    private let idContactsCell = "idContactsCell"
    
    private let searchController = UISearchController()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Контакты"
        settingsForTableView()
        createBarButton()
        settingsForSearchVC()
    }
    private func settingsForTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        tableView.backgroundColor = .cyan
//        tableView.separatorStyle = .none
    }
    
    private func createBarButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func settingsForSearchVC() {
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
    }
    
    @objc private func addButtonTapped() {
        let contactOptionTVC = ContactOptionTableViewController()
        navigationController?.pushViewController(contactOptionTVC, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension ContactsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as? ContactsTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
