//
//  ViewController.swift
//  RickAndMorty's
//
//  Created by Макар Тюрморезов on 26.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var characterLabel: UILabel!
    
    // MARK: - Private properties
    private var dataCopy = [CharacterSet]()
    private var data: [CharacterSet]? = []
    private var pageNumber = 1
    private var service = NetworkManager()
    private var filteredCharacters = [CharacterSet]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        initializeSetup()
        applyStyle()
        setupText()
        searchControlSetup()
        
}
    
    // MARK: - Private methods
    
    private func loadData() {
            self.service.getResult(page: self.pageNumber) { (searchResponse) in
                switch searchResponse {
                case .success(let data):
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                            self.pageNumber += 1
                            self.data?.append(contentsOf: data.results ?? [])
                            self.tableView.reloadData()
                    }

                case .failure(_):
                        print("Hop")
                }
            }
    }
    
    private func loadChar(name: String) {
        self.service.getCharName(name: name) { (searchResponse) in
                switch searchResponse {
                case .success(let data):
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.filteredCharacters.append(contentsOf: data.results ?? [])
                        self.tableView.reloadData()
                        
                        self.dataCopy = data.results ?? []
                        if data.results == nil {
                            self.characterLabel.text = "Characters not found"
                        } else {
                            self.characterLabel.text = "Rick & Morty Characters!"
                        }
                    }
                case .failure(_):
                        print("Hop")
                }
            }
    }
    
    private func initializeSetup() {
        
        tableView.register(UINib(nibName: "MortyTableViewCell", bundle: nil), forCellReuseIdentifier: "mortyID")
        
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchResultsUpdater = self
    }
}
    // MARK: - Extention for TableView DataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return (searchController.isActive ? filteredCharacters : data )?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mortyID", for: indexPath) as! MortyTableViewCell
        
        if self.searchController.isActive, searchController.searchBar.text?.count ?? 0 >= 3 {
            cell.configure(withModel: filteredCharacters[indexPath.row])
        } else {
            cell.configure(withModel: data?[indexPath.row])
        }
        return cell

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            loadData()
        }
    }
}

// MARK: - Extention for TableView Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "CharacterDescription", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MortyDescript") as! CharacterDescription
        let backItem = UIBarButtonItem(title: "", style: .bordered, target: nil, action: nil)
        
        if searchController.searchBar.text?.count ?? 0 >= 2 {
            vc.characterAttributes = dataCopy[indexPath.row]
            vc.title = dataCopy[indexPath.row].status
        } else {
            vc.characterAttributes = data?[indexPath.row]
            vc.title = data?[indexPath.row].status
        }
        navigationItem.searchController = searchController
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extention for styling

extension ViewController {
    
    func applyStyle() {
        tableView.separatorStyle = .none
        view.backgroundColor = .systemGreen
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - Extention for setup text

extension ViewController {
    
    func setupText() {
        characterLabel.font = .boldSystemFont(ofSize: 24)
        characterLabel.textAlignment = .center
        characterLabel.text = "Rick & Morty characters!"
        
        characterLabel.backgroundColor = .systemGreen
    }
}
// MARK: - Extention for SearchBar (active if symbols count > 3)

extension ViewController: UISearchResultsUpdating {

func updateSearchResults(for searchController: UISearchController) {

    let text = searchController.searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    if searchController.searchBar.text?.count ?? 0 >= 3 {
        filteredCharacters = []
        loadChar(name: text ?? "")
        }
    }
}

// MARK: - Extention for SearchBar's visuality

extension ViewController {
    
    func searchControlSetup() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find a character"
    }
}
