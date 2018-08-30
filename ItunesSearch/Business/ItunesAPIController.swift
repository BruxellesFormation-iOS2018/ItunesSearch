//
//  ItunesAPIController.swift
//  ItunesSearch
//
//  Created by Florian Praile on 29/08/2018.
//  Copyright © 2018 Underside. All rights reserved.
//

import Foundation

class ItunesAPIController{
    
    static let shared = ItunesAPIController()
    
    static let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var favoriteItems = [StoreItem]()
    
    func search(withQuery query: [String: String], completionHandler: @escaping ([StoreItem]) -> Void){
        let searchURL = ItunesAPIController.baseURL.withQueries(query)!
        URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
            
            if let data = data{
                let searchValues: [StoreItem]
                do{
                    let storeItems = try JSONDecoder().decode(StoreItems.self, from: data)
                    searchValues = storeItems.results
                }catch{
                    print("Parsing Error: \(error)")
                    searchValues = []
                }
                DispatchQueue.main.async {
                    completionHandler(searchValues)
                }                
            }
        }.resume()
    }
}
