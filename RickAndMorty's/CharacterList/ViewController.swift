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
    
    private var data = [CharactersModel]()
    private var pageNumber = 1
    private var service = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initializeSetup()
    
    }
    // MARK: - Actions (refreshing)
    
    func loadData() {
        service.getResult(page: pageNumber) { (searchResponse) in
            switch searchResponse {
                
            case .success(let data):
                DispatchQueue.main.async {
                    self.pageNumber += 1
                    data?.forEach {
                        self.data.append($0)
                    }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                      print("Hop")
            }
        }
    }
    
    
    private func initializeSetup() {
        let nib = UINib(nibName: "MortyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "mortyID")
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mortyID", for: indexPath) as! MortyTableViewCell
        
        let cellData = data.map{$0.results}
        let model = cellData[indexPath.row]
        
        cell.configure(withModel: model)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
