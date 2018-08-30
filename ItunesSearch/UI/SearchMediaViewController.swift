//
//  ViewController.swift
//  ItunesSearch
//
//  Created by Florian Praile on 29/08/2018.
//  Copyright © 2018 Underside. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchMediaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var mediaResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var mediaResults: [StoreItem]?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        self.mediaResultsTableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mediaResults?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mediaResultsTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MediaTableViewCell
        cell.media = self.mediaResults![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search is \(searchText)")
        
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.launchSearch(withTerm: searchText)
        })
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.launchSearch(withTerm: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.fadeIn()
    }
    
    func launchSearch(withTerm term: String){
        let query: [String: String] = [
            "term": term,
            "media": "movie"
        ]
        
        ItunesAPIController.shared.search(withQuery: query) { (searchResults) in
            
            self.mediaResults = searchResults
            self.mediaResultsTableView.reloadData()
        }
    }
    
}

