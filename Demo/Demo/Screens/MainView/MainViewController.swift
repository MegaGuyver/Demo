//
//  MainViewController.swift
//  Demo
//
//  Created by khawaja fahad on 30/12/2023.
//

import UIKit
import SwiftLoader


class MainViewController: UIViewController {
    
    @IBOutlet weak var tableViewMostPopular: UITableView!
    
    lazy var viewModel = {
        MainViewControllerViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRecipients()
        SwiftLoader.show(title: "Fetching...", animated: true)
    }

}

// MARK: Helper Methods
extension MainViewController {
    
    func setUpTableView() {
        tableViewMostPopular.delegate = self
        tableViewMostPopular.dataSource = self
        
        tableViewMostPopular.register(MostPopularTableViewCell.nib, forCellReuseIdentifier: MostPopularTableViewCell.identifier)
    }
    
    func fetchRecipients() {
        viewModel.fetchMostPopular()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
            self.tableViewMostPopular.reloadData()
            SwiftLoader.hide()
       }
        }
    }
}

// MARK: UITableViewDelegate UITableViewDataSource Methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MostPopularTableViewCell.identifier) as? MostPopularTableViewCell else { return UITableViewCell() }
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 106
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        nextViewController.urlString = viewModel.results[indexPath.row].url
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
