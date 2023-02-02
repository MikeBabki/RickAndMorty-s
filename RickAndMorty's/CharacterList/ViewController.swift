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
    
    private var data: [CharacterSet]? = []
    private var pageNumber = 1
    private var service = NetworkManager()
    private var networkCharacters = NetworkManager()
    
    // MARK: - Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        initializeSetup()
        applyStyle()
        setupText()
        
}
    
    // MARK: - Private methods
    
    private func loadData() {
            self.service.getResult(page: self.pageNumber) { (searchResponse) in
                switch searchResponse {
                case .success(let data):
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                            self.pageNumber += 1
//                            self.data! += data.results!
                            self.data?.append(contentsOf: data.results ?? [])
                            self.tableView.reloadData()
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
    }
}
    // MARK: - Extention for TableView DataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mortyID", for: indexPath) as! MortyTableViewCell

        cell.configure(withModel: data?[indexPath.row])
        
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
        
        vc.characterAttributes = data?[indexPath.row]
        
        vc.title = data?[indexPath.row].status
        
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
