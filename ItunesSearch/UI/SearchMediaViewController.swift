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

    //MARK:- Class Properties
    static let mediaDetailsSegue = "MediaDetails"
    
    //MARK: Instance Properties
    private(set) var mediaResults: [StoreItem]?
    private(set) var lastSearchTerm: String = ""
    private var launchSearchTimer: Timer?
    
    
    //MARK: IBOutlets Properties
    @IBOutlet weak var mediaResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    //MARK:- ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        self.mediaResultsTableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedRow = self.mediaResultsTableView.indexPathForSelectedRow{
            self.mediaResultsTableView.deselectRow(at: selectedRow, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mediaDetailsVC = segue.destination as? MediaDetailsViewController{
            mediaDetailsVC.media = sender as? StoreItem
        }
    }
    
    //MARK:- TableView Datasource
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
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.fadeIn(delay: 0.25)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = self.mediaResults![indexPath.row]
        self.performSegue(withIdentifier: SearchMediaViewController.mediaDetailsSegue , sender: media)
    }
    
    //MARK:- SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.launchSearchTimer?.invalidate()
        
        self.launchSearchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
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
    
    
    //MARK:- Private Stuff
    private func launchSearch(withTerm term: String){
        
        guard !term.isEmpty && self.lastSearchTerm != term else {
            return
        }
        
        
        
        let query: [String: String] = [
            "term": term,
            "media": "movie"
        ]
        
        ItunesAPIController.shared.search(withQuery: query) { (searchResults) in
            if searchResults.isEmpty{
                let alert = UIAlertController(title: "Not Found", message: "Your request for '\(term)' did not match any results", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel)
                alert.addAction(dismiss)
                self.present(alert, animated: true)
            }
            self.mediaResults = searchResults
            self.mediaResultsTableView.reloadData()
            self.lastSearchTerm = term
        }
    }
    
    
    
    
}

