//
//  ViewController.swift
//  TableView
//
//  Created by Miguel Ferrer Fornali on 26/6/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet var tableView: UITableView!
    
    let people: [Person] = [
        Person(name: "Miguel", surname: "Ferrer Fornali", age: 22),
        Person(name: "Joan", surname: "Ferrer Fornali", age: 20),
        Person(name: "Enrique", surname: "Juan Sempere", age: 21)
    ]
    
    var filteredPeople: [Person]!
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        filteredPeople = people
    }
    
    // Table View functions...
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPersonSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = filteredPeople[indexPath.row].name
        cell.detailTextLabel?.text = filteredPeople[indexPath.row].surname
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPersonSegue",
           let destination = segue.destination as? PersonViewController,
           let personIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.person = filteredPeople[personIndex]
        }
    }
    
    //Search Controller functions...
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        filteredPeople = []
        
        if searchText.isEmpty {
            filteredPeople = people
        } else {
            for person in people {
                if person.name.lowercased().contains(searchText.lowercased()) || person.surname.lowercased().contains(searchText.lowercased()) {
                    filteredPeople.append(person)
                }
            }
        }
        
        tableView.reloadData()
    }
}
