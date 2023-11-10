//
//  RepTableViewController.swift
//  API Project
//
//  Created by Tyler May on 11/9/23.
//

import UIKit

class RepTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    let repController = RepController()
    var rep: [RepResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rep.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepDetail", for: indexPath)
        configureCell(cell, forZipAt: indexPath)

        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forZipAt indexPath: IndexPath) {
        guard let repCell = cell as? RepTableViewCell else {
            return
        }
        
        let rep = rep[indexPath.row]
        
        repCell.repName = rep.name
        repCell.repState = rep.state
        repCell.repWebsite = rep.website?.absoluteString
        repCell.repParty = rep.party
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let zipCode = searchBar.text {
            fetchRepresentatives(forZipCode: zipCode)
        }
        searchBar.resignFirstResponder()
    }
    
    func fetchRepresentatives(forZipCode zipCode: String) {
        Task {
            do {
                print("preRep")
                rep = try await repController.fetchReps(forZipCode: zipCode)
                print("postRep")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                let alertController = UIAlertController(title: "Error", message: "Cannot find zip code.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
    }



}
