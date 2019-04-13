//
//  ViewController.swift
//  Project 7
//
//  Created by Nadya Postriganova on 13/4/19.
//  Copyright © 2019 Nadya Postriganova. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var petitions = [Petition]()
  var filteredPetitions = [Petition]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterTapped))

    let urlString: String
    
    if navigationController?.tabBarItem.tag == 0 {
      urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
      
    } else {
      urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
      
    }
    if let url = URL(string: urlString) {
      if let data = try? Data(contentsOf: url) {
        parse(json: data)
        return
      }
    }
    showError()
  }
  func parse(json: Data) {
    let decoder = JSONDecoder()
    
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results
      filteredPetitions = petitions
      tableView.reloadData()
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredPetitions.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let petition = filteredPetitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = filteredPetitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
    
  }
  
  func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  @objc func creditsTapped() {
    let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Ok", style: .default))
    
    present(ac, animated: true)
  }
  
  @objc func filterTapped() {
    let ac = UIAlertController(title: "What you are looking for?", message: nil, preferredStyle: .alert)
    ac.addTextField()
    let searchAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ in
      guard let wordToLookFor = ac?.textFields?[0].text else { return }
      self?.search(wordToLookFor)
    }
    ac.addAction(searchAction)
    present(ac, animated: true)

  }

  func search(_ wordToLookFor: String) {
    if wordToLookFor.count <= 2 {
      filteredPetitions = petitions
      tableView.reloadData()
      return
    }
    filteredPetitions = []
    
    for petition in petitions {
      if petition.body.contains(wordToLookFor) {
        filteredPetitions.append(petition)
      }
    }
    tableView.reloadData()

    }

}
