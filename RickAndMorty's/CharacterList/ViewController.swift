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
    
    // MARK: - Private properties
    
    private var data: [CharacterSet]? = []
    private var pageNumber = 1
    private var service = NetworkManager()
    
    // MARK: - Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        initializeSetup()
        applyStyle()
    }
    
    // MARK: - Private methods
    
    private func loadData() {
        service.getResult(page: pageNumber) { (searchResponse) in
            switch searchResponse {
            case .success(let data):
                DispatchQueue.main.async {
                    self.pageNumber += 1
                    self.data = data?.results
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
}

// MARK: - Extention for TableView Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "CharacterDescription", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MortyDescript") as! CharacterDescription
        
        vc.characterAttributes = data?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extention for styling

extension ViewController {
    
    func applyStyle() {
        tableView.separatorStyle = .none
    }
}


