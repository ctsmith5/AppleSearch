//
//  AppItemController.swift
//  AppleSearch2
//
//  Created by Colin Smith on 3/21/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation


class AppStoreItemController {
    
    static let baseUrl = URL(string: "https://itunes.apple.com/search")
    static func fetchItemsOf(type: AppStoreItem.ItemType, searchTerm: String, completion: @escaping ([AppStoreItem]?) -> Void){
        //1)Construct the URL/URLRequest
        guard let baseUrl = baseUrl?.appendingPathComponent("search"),
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else { completion(nil) ; return}
        let querySearchTerm = URLQueryItem(name: "term", value: searchTerm)
        let queryItemType = URLQueryItem(name: "entity", value: type.rawValue)
        components.queryItems = [querySearchTerm, queryItemType]
        guard let finalUrl = components.url else {completion(nil) ; return}
        
        //2)Call our Datatask (decode ; .resume)
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            if let error = error {
                print(" \(error.localizedDescription) \(error) in function \(#function) ")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil) ; return}
            do {
                guard let outerMostDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let resultsArray = outerMostDictionary["results"] as? [[String:Any]] else { completion(nil) ; return}
                
                let appStoreItems = resultsArray.compactMap{AppStoreItem(itemType: type, dictionary: $0)}
                completion(appStoreItems)
                
                
            }catch {
                print("There was an error in \(#function) : \(error.localizedDescription) ")
                completion(nil)
                return
            }
            
        }
    }
}
