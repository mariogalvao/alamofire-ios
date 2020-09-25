//
//  SearchPetsViewController.swift
//  URLSession
//
//  Created by Mário Galvao on 24/09/20.
//

import UIKit

class SearchViewController: ViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var petApi = PetAPI()
    
    var pets: [Pet] = [] {
        didSet {
            filteredPets = pets
        }
    }
    var filteredPets: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        loadPets(by: .available)
    }
    
    // MARK: Private functions
    
    private func loadPets(by status: Pet.Status) {
        petApi.getPets(by: status) { (result) in
            switch result {
            case .success(let pets):
                DispatchQueue.main.async {
                    self.pets = pets
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.alertError(error)
            }
        }
    }
    
    private func updateSearchText(text: String) {
        if text.isEmpty {
            filteredPets = pets
        } else {
            filteredPets = pets.filter({ $0.name.caseInsensitiveCompare(text) == .orderedSame || $0.name.caseInsensitiveCompare(text) == .orderedDescending })
        }
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadPets(by: .available)
        case 1:
            loadPets(by: .pending)
        case 2:
            loadPets(by: .sold)
        default:
            break
        }
    }
    

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchText(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as? PetTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row <= filteredPets.count - 1 {
            cell.setPet(filteredPets[indexPath.row])
        }
        
        
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
    
}
