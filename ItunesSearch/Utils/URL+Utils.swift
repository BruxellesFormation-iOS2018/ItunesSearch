//
//  URL+Utils.swift
//  ItunesSearch
//
//  Created by Florian Praile on 29/08/2018.
//  Copyright © 2018 Underside. All rights reserved.
//

import Foundation

extension URL {
    
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
